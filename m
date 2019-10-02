Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66ADC9005
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 19:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfJBReH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 13:34:07 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:35330 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfJBReG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 13:34:06 -0400
Received: by mail-vk1-f201.google.com with SMTP id a7so9882981vkg.2
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C1D1kzTkz2Dv8wvm8Zub4IEsPufosLDrzNHzbSwrweg=;
        b=IQovO54U0kPn4WqnL87otCcxgT1KqOADcQIojQ3dU1Q3n18yO6BOaaboYRjSgyLsIy
         3/zrCH3JG4HQj8x8VnXU21mtAUjb3Yb2adzSmJ3S3AjNktPektUdltKt+k247+PgOnCr
         f9DyxXeMaf1TWnPOPwFB2bV2+AJYxXwj98RRNDDxBD2xXcvYrg1QwvJ5eWbmsfOfbZzz
         LDZiCeCJPY0J32KgETiDt4Dj77wA37Yzkiz8+tKWWOzr1mqWb8m+T1NHvRhJCDkwA9qD
         nC4FUwnK4SUT7vWgtbysH+QROUF6JZjmlS5smqtRBnIVEpuXtXiZEfNu35Uytxr5ol8A
         xLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C1D1kzTkz2Dv8wvm8Zub4IEsPufosLDrzNHzbSwrweg=;
        b=VKaOe9RpIyRaoS/88t5qyxfuZAF/fxUe1c0Xswx3p6EzzxKr3QSVq4D1trMdTuKaW+
         YkhxUQzamRF5yTSB+GH9wdRisXcyk72Pvogx0tQMECxe2bmaRuKXcfjmEwbeNBfVBVgr
         dUFWwvHGB6gN6m+tRuH+vysmEUesU7Gyc2h50Ll5EJ91RPwXbgOXLGa5x8paxgfeL/LT
         uGmkd3+axSkJ9j3ql3/1ljymkuV/WMlEIUHFanfnMDsRdLAX9DASmlrXmfPuX+FC9dPM
         VXmcXlRiiCZDlBzD7gNU/RkUODqpQxqnixh+3/4GVPBjdZ7QtON6wuCcp+IegfqYKm3y
         irQA==
X-Gm-Message-State: APjAAAX9i6dUsZkTX87NEKZmE2h0LSzYwMcyVI5DJYxKruPydEJfFYj7
        dynaQksnW3X5h+RwylMR6BNozwo=
X-Google-Smtp-Source: APXvYqwvx+DywmCPcQk3DwmLhDisRGAMmSFciHb7akUWW7zxjxP5tGg5okBftXOosZ7kDnO5gsKQJb0=
X-Received: by 2002:a1f:28b:: with SMTP id 133mr2702061vkc.8.1570037645391;
 Wed, 02 Oct 2019 10:34:05 -0700 (PDT)
Date:   Wed,  2 Oct 2019 10:33:57 -0700
In-Reply-To: <20191002173357.253643-1-sdf@google.com>
Message-Id: <20191002173357.253643-3-sdf@google.com>
Mime-Version: 1.0
References: <20191002173357.253643-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: add test for BPF flow dissector
 in the root namespace
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure sub-namespaces get EPERM if root flow dissector is
attached.

Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/test_flow_dissector.sh      | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
index d23d4da66b83..2c3a25d64faf 100755
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
@@ -18,19 +18,55 @@ fi
 # this is the case and run it with in_netns.sh if it is being run in the root
 # namespace.
 if [[ -z $(ip netns identify $$) ]]; then
+	err=0
+	if bpftool="$(which bpftool)"; then
+		echo "Testing global flow dissector..."
+
+		$bpftool prog loadall ./bpf_flow.o /sys/fs/bpf/flow \
+			type flow_dissector
+
+		if ! unshare --net $bpftool prog attach pinned \
+			/sys/fs/bpf/flow/flow_dissector flow_dissector; then
+			echo "Unexpected unsuccessful attach in namespace" >&2
+			err=1
+		fi
+
+		$bpftool prog attach pinned /sys/fs/bpf/flow/flow_dissector \
+			flow_dissector
+
+		if unshare --net $bpftool prog attach pinned \
+			/sys/fs/bpf/flow/flow_dissector flow_dissector; then
+			echo "Unexpected successful attach in namespace" >&2
+			err=1
+		fi
+
+		if ! $bpftool prog detach pinned \
+			/sys/fs/bpf/flow/flow_dissector flow_dissector; then
+			echo "Failed to detach flow dissector" >&2
+			err=1
+		fi
+
+		rm -rf /sys/fs/bpf/flow
+	else
+		echo "Skipping root flow dissector test, bpftool not found" >&2
+	fi
+
+	# Run the rest of the tests in a net namespace.
 	../net/in_netns.sh "$0" "$@"
-	exit $?
-fi
+	err=$(( $err + $? ))
 
-# Determine selftest success via shell exit code
-exit_handler()
-{
-	if (( $? == 0 )); then
+	if (( $err == 0 )); then
 		echo "selftests: $TESTNAME [PASS]";
 	else
 		echo "selftests: $TESTNAME [FAILED]";
 	fi
 
+	exit $err
+fi
+
+# Determine selftest success via shell exit code
+exit_handler()
+{
 	set +e
 
 	# Cleanup
-- 
2.23.0.444.g18eeb5a265-goog


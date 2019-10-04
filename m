Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2803DCBFDB
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbfJDP4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 11:56:24 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:47609 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390156AbfJDP4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 11:56:23 -0400
Received: by mail-yw1-f74.google.com with SMTP id p205so6120553ywc.14
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dSnbP5Jkis+rn77OzXcSHwYP7eOSGch4IOdOZ3lKMAI=;
        b=Im2RWn74vOKBgu9Poi6W/dO0NUqLg9bxxDf/THc48zCMcb8BNJcprvjqtPrdhLDZjc
         +wkFdGSW55YHNIkllq2xcHaH8fqiG47oMVCqlKUxAMIsG650R828Nwg4aV9cXI3mKYgK
         PoM5nB2Z6fOcoMci2sWkUUEg2G0YXfM9ffPqIvJobhlVTRsxzDIfbeFt8p8amdJEsYSF
         0upS5bHX1Hlzqe0nB7BC3r2zlB/7ClBn/XdmEtCaVYvRiwng0QUCtL7S0S/TPANMFhFI
         a+6l2cO9TN8A2hqhAxOL5BW968IwDg+ggI16mZC2hUe3bLUjEOeNmrCYT/+JIkz48/XO
         hopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dSnbP5Jkis+rn77OzXcSHwYP7eOSGch4IOdOZ3lKMAI=;
        b=LrSs/SQH1OaaAx8laYrdbZsWyqpZLz2csKsQ7XrIEO1sOwkEYynm2a4VMICqqKXvAJ
         8egVfIccNiC4Xfd1ni0fesp764DPCn9FNUFKlnbQh6hPv7qMUjTboqms0cIvo1a6cxhq
         qHrrV7y9O8HUqrvC/fUvW+jd4cB2ufTgYy+0ktsFHXIp0zqNLT16QZnC6iw5Jgw2vJ8G
         vJE5aVbhKnCjDmAKTLWGLbbNNBzwtJAp/B1eTANhE5Jmc2XmkkxiVehBchkZ4xvnYzeb
         0q1KNGy4jSk4ALcg6x/535t6yZCJao9hPwDSBE3Qxm+kbfCZ6/7xbsAZUtoRZ2XFBm0a
         J2wg==
X-Gm-Message-State: APjAAAX1OAxJ9FHiM2wIez6kvDGJgkl/ZGOUpxJ1BQ9RfvNquAzVzjhf
        tNF60swCvwwQO4/zWP9FQ3oR7NM=
X-Google-Smtp-Source: APXvYqx9ao7IS9HtEjI17gkBC+SDiaid6NDXJm8QkifSIxXPThWEQ+JeZcbfwmaHh+pLCYaIyelWl/8=
X-Received: by 2002:a81:8203:: with SMTP id s3mr11007383ywf.235.1570204582427;
 Fri, 04 Oct 2019 08:56:22 -0700 (PDT)
Date:   Fri,  4 Oct 2019 08:56:15 -0700
In-Reply-To: <20191004155615.95469-1-sdf@google.com>
Message-Id: <20191004155615.95469-3-sdf@google.com>
Mime-Version: 1.0
References: <20191004155615.95469-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add test for BPF flow
 dissector in the root namespace
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

Make sure non-root namespaces get an error if root flow dissector is
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
2.23.0.581.g78d2f28ef7-goog


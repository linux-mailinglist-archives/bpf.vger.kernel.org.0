Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9D2A14C
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 00:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbfEXW27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 18:28:59 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:56792 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404292AbfEXW27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:28:59 -0400
Received: by mail-yb1-f202.google.com with SMTP id d10so9534971ybs.23
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qMovpOHh9UtpX8EWlQ95Jzm7k03iPOrye3cAHpJ3zYQ=;
        b=KfgHzn9r8xCSmWgerdWxC8Ns29cWdiSikWuFUwitGwmhONaLHS8vDzNGD8UqZpU7IS
         CiXXVjqxt/wNr6RibGUY6Q8gfwCNm0DDp8fR8EjUA/fFGkWXNMWEXcZ3ETWDIzFHW2Oc
         ckEZH43uNfspsOS+/EdsCpVNhE/y0GPrma8tiYmDoo+cC1u9+FTszylquvZvDmVLu+Ph
         eLKAjqXauuarecZ8q+nqjDRKbHaHA+O9zK9i+g4fpGULddgX9PDKgyFIpnKj2OJWZH2L
         xcmjJPYUM3dkdpWfVt9o8Fti563DgSjfbfSoN+Ep852SM9gmbf6wJP1erHU1NXAjn0Lj
         gR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qMovpOHh9UtpX8EWlQ95Jzm7k03iPOrye3cAHpJ3zYQ=;
        b=Xa4DKwYXm5X4kTWBnBXZmA9gdZCsM1dqpeXQ6c6byz3oxpbr7+8FPj9Zm6WFzcdduO
         Uh89agA4VLCEKSsn63DQwdEk9SaRkDlLwOLd0DYlO1RjvjmAfJVoaG0ZFs9mQeXpJGcs
         2IiBq/H/+YKTmY8kbd+wuVw3NdGn0ZMpKGmlpqGdWWmsyrU84SDrcJ1js4eeq3zmsBP5
         pCSVUsLmaq29HYrM3MDAOZ+W/3f+TlekwNUI+TM8KQprwJhgEgnzQZ/l6Z10MLjWdo1L
         LkPeTuXa1CG3j/IeINBrWM0R74eWk/p0OrJJ2GHRJ7LjUnNU2CsvPvaky09WvWTW6TVr
         MPEw==
X-Gm-Message-State: APjAAAVaVzlDfCnAX4xebZQ4Q9Vz9ki3Gy+Dn2vxctnEPW4NxX/+ouYC
        eNXVEuSpad8CT1OaRqAcqL5QLu4=
X-Google-Smtp-Source: APXvYqwvw2SZ5X/QNkZ6/+2TCJlkZZPZce/COZVnliwqSeRGjFGUS4SdX93WAElCjn8NvDmGmjp5zJk=
X-Received: by 2002:a25:2487:: with SMTP id k129mr9156184ybk.91.1558736938114;
 Fri, 24 May 2019 15:28:58 -0700 (PDT)
Date:   Fri, 24 May 2019 15:28:56 -0700
Message-Id: <20190524222856.60646-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH bpf-next] selftests/bpf: fail test_tunnel.sh if subtests fail
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now test_tunnel.sh always exits with success even if some
of the subtests fail. Since the output is very verbose, it's
hard to spot the issues with subtests. Let's fail the script
if any subtest fails.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 546aee3e9fb4..bd12ec97a44d 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -696,30 +696,57 @@ check_err()
 
 bpf_tunnel_test()
 {
+	local errors=0
+
 	echo "Testing GRE tunnel..."
 	test_gre
+	errors=$(( $errors + $? ))
+
 	echo "Testing IP6GRE tunnel..."
 	test_ip6gre
+	errors=$(( $errors + $? ))
+
 	echo "Testing IP6GRETAP tunnel..."
 	test_ip6gretap
+	errors=$(( $errors + $? ))
+
 	echo "Testing ERSPAN tunnel..."
 	test_erspan v2
+	errors=$(( $errors + $? ))
+
 	echo "Testing IP6ERSPAN tunnel..."
 	test_ip6erspan v2
+	errors=$(( $errors + $? ))
+
 	echo "Testing VXLAN tunnel..."
 	test_vxlan
+	errors=$(( $errors + $? ))
+
 	echo "Testing IP6VXLAN tunnel..."
 	test_ip6vxlan
+	errors=$(( $errors + $? ))
+
 	echo "Testing GENEVE tunnel..."
 	test_geneve
+	errors=$(( $errors + $? ))
+
 	echo "Testing IP6GENEVE tunnel..."
 	test_ip6geneve
+	errors=$(( $errors + $? ))
+
 	echo "Testing IPIP tunnel..."
 	test_ipip
+	errors=$(( $errors + $? ))
+
 	echo "Testing IPIP6 tunnel..."
 	test_ipip6
+	errors=$(( $errors + $? ))
+
 	echo "Testing IPSec tunnel..."
 	test_xfrm_tunnel
+	errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 trap cleanup 0 3 6
@@ -728,4 +755,9 @@ trap cleanup_exit 2 9
 cleanup
 bpf_tunnel_test
 
+if [ $? -ne 0 ]; then
+	echo -e "$(basename $0): ${RED}FAIL${NC}"
+	exit 1
+fi
+echo -e "$(basename $0): ${GREEN}PASS${NC}"
 exit 0
-- 
2.22.0.rc1.257.g3120a18244-goog


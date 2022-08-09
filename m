Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7F58DCE6
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbiHIROL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiHIROK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:14:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1624F0A;
        Tue,  9 Aug 2022 10:14:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C9D11320095A;
        Tue,  9 Aug 2022 13:14:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 13:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1660065248; x=1660151648; bh=Y2
        vLDOx8dQXCiR8IQJdil5G4h9Cpiut6CvYWI0fO7c4=; b=CPcQx8KuEH/7ORSc9F
        VlN+rsReujPhWo+E5a1UNOXDKsK6yi+eX6pDRCte0kmSYYdkg8ycCRm67HAPnf05
        JztK9MXM9gj485zI8Ocs+H9dyUR3UQ2gIeMbaJC2b+F8gYW6o0rtfa2oq95WgLxO
        k8Pi7cWB0gYm9hxlB+cEfHs3ZaP5Joprd5qsYMxzFNDuyBNiCGb9lBYt3qZYZOVm
        z33j93pin1O4SRxSZ3rmITjZr6pNXojmGlRP98cOT0WgooNgP3zzMTxG8dURFF4N
        uDfzx8Oa85/v+H7YfBgvFh6GyTBYb7DrstEr9KZEwkoO0KoHG6db05bgpfrJLyhp
        z99Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660065248; x=1660151648; bh=Y2vLDOx8dQXCi
        R8IQJdil5G4h9Cpiut6CvYWI0fO7c4=; b=EkLqdOVNpjHMNNj31Oi1MAYmTO1dp
        j0UeWmT6msf3ounleDyMLwz51wyKQKrn2+5+LgPxCCh9fMwE0Hvbcmlro2kH6Isf
        Hc38e3TsUIx/jBB6KPoGVUlAInBeFjrx3x0vWEXtbtht0fyTY+LrLd3QmmtXPfbv
        BEOMEOOpoXcq1SKpqM1Qy5NEm4SI7GmTf9+oYnrY/E9qM3FgtITvu7GiQH5tbbP/
        KK4ayMo7V+H8AdfcTMHHXNiI5S04dKLm6KSf6fHAxWnPsQQ9O7NYdNeE4alro6Eb
        O7HYwHewBtOS1iw6rEZ9E6cD7jJINkGjRc63bFSpsOnBjHeJRtAV46heA==
X-ME-Sender: <xms:4JXyYql0tsmKCA98uqknEXUBTV_Mj8dNzlr53istpdqAE4vG1VLbWg>
    <xme:4JXyYh2eQTGB_ZlgVjT6FSDjR4gEgpzWT4xcCb9FZkOgHCEbTSuFVJbK3ez8lBZTm
    I678TvQQ79sxENBJw>
X-ME-Received: <xmr:4JXyYoq4Gs1zdLGYWCy5gEn_PS6IGdIEPEn7nKrZL4Fi751qsZtqqb5Zq76254nbU1yQw23LV0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:4JXyYun6R2aBgLwaO8s8lV9kmWHNKtBES_-tgQPjK14cNyJ6k_IWvA>
    <xmx:4JXyYo3vItGe45P5E36S-27Mg0KS5v8gayB3GalIyeSBxPgLcjcWHg>
    <xmx:4JXyYltJ-wuuIGacs2Uqa4XcfZg82OEpw7iMyyfpktk_Lt8Z0WgrQQ>
    <xmx:4JXyYs_HM-QzB3TBZTnplIXoVl03QSBYsc8Nr5AZJRt_1fDpZS6J6g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 13:14:06 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] selftests/bpf: Fix vmtest.sh -h to not require root
Date:   Tue,  9 Aug 2022 11:11:09 -0600
Message-Id: <6a802aa37758e5a7e6aa5de294634f5518005e2b.1660064925.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660064925.git.dxu@dxuuu.xyz>
References: <cover.1660064925.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Set the exit trap only after argument parsing is done. This way argument
parse failure or `-h` will not require sudo.

Reasoning is that it's confusing that a help message would require root
access.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/vmtest.sh | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index b86ae4a2e5c5..976ef7585b33 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -307,6 +307,20 @@ update_kconfig()
 	fi
 }
 
+catch()
+{
+	local exit_code=$1
+	local exit_status_file="${OUTPUT_DIR}/${EXIT_STATUS_FILE}"
+	# This is just a cleanup and the directory may
+	# have already been unmounted. So, don't let this
+	# clobber the error code we intend to return.
+	unmount_image || true
+	if [[ -f "${exit_status_file}" ]]; then
+		exit_code="$(cat ${exit_status_file})"
+	fi
+	exit ${exit_code}
+}
+
 main()
 {
 	local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
@@ -353,6 +367,8 @@ main()
 	done
 	shift $((OPTIND -1))
 
+	trap 'catch "$?"' EXIT
+
 	if [[ $# -eq 0  && "${debug_shell}" == "no" ]]; then
 		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
 	else
@@ -409,20 +425,4 @@ main()
 	fi
 }
 
-catch()
-{
-	local exit_code=$1
-	local exit_status_file="${OUTPUT_DIR}/${EXIT_STATUS_FILE}"
-	# This is just a cleanup and the directory may
-	# have already been unmounted. So, don't let this
-	# clobber the error code we intend to return.
-	unmount_image || true
-	if [[ -f "${exit_status_file}" ]]; then
-		exit_code="$(cat ${exit_status_file})"
-	fi
-	exit ${exit_code}
-}
-
-trap 'catch "$?"' EXIT
-
 main "$@"
-- 
2.37.1


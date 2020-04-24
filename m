Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96961B7708
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDXNeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 09:34:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgDXNeg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 09:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587735275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sfWX9k4RpGMfjYkdXBp2fwU91Q/pjg1D/U3CLDJOezE=;
        b=ZeKNtttuM9xK2X2yPy52gjUSYk9uprVUVR8iEdu+ndxjTedNfrLHzYaD5pcKwbe+pJ580O
        XALIgtS1Sn4HtqreTw0Im8QsW1hUFh//E+7R1FA/7QouY67k1s8VkvmRXhRkmZUMwbs+FP
        WQmhoGVwccNsKOcqjMCBEDsmRp+vczE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-AtiwBg44OyOyiBePVx5hbQ-1; Fri, 24 Apr 2020 09:34:33 -0400
X-MC-Unique: AtiwBg44OyOyiBePVx5hbQ-1
Received: by mail-lf1-f69.google.com with SMTP id g5so3903433lfh.9
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 06:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=sfWX9k4RpGMfjYkdXBp2fwU91Q/pjg1D/U3CLDJOezE=;
        b=PTeHwNGPVDN4XnTD+aEAfGo2XVYejfQ142412eNCeLMrW/y1U7FB7Q7LhYRBNNH5Wn
         2Vh83a9w/xuQ5tGQuDR5QQAw7uf6qF3D06NhE2gS3ergx4X/R8flStOVwe06z4aCPYWd
         xkFCNUUJIbjjqrzxx2ds9FAgInrrGrDF2E+H0GyO151nCeLq9ZEC/TloasrGT+FNSkAa
         JrYo8/uwZQDdQb/YHtwdujylWGPmkUCNXl5inRar3/9oCZQvqyk47xVthPCqkO3qHtH2
         5c3QOthqiB9tuD6JUp06soB81h9jkvgIqSnkX2RWKIzrUy8A83HRTKgrJBsMsvSgqUz6
         8QOw==
X-Gm-Message-State: AGi0PuYZ2aZrBl5tcFJwBt2ffyAIgYXuNMoPuzn4OEdoJNJPUlBcPzJv
        FHkH/fDucSdMnDg2lJLR2BdxjhV4PkfvHzmG8By25dD+vO0LSmSJOZViigTIWMuECzHL6SjRYaM
        hMO4Q7ffghQEm
X-Received: by 2002:a2e:b4d5:: with SMTP id r21mr5891285ljm.49.1587735271456;
        Fri, 24 Apr 2020 06:34:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHtihKJx5Vyo3DlTmw9BOorXzeh8ffl2Fss/lbUMw5BwicF+pW9YzBkYQ5UzVUWieyRPPqTA==
X-Received: by 2002:a2e:b4d5:: with SMTP id r21mr5891273ljm.49.1587735271157;
        Fri, 24 Apr 2020 06:34:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x29sm4433680lfn.64.2020.04.24.06.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 06:34:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 520461814FF; Fri, 24 Apr 2020 15:34:27 +0200 (CEST)
Subject: [PATCH bpf 1/2] bpf: Propagate expected_attach_type when verifying
 freplace programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>
Date:   Fri, 24 Apr 2020 15:34:27 +0200
Message-ID: <158773526726.293902.13257293296560360508.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

For some program types, the verifier relies on the expected_attach_type of
the program being verified in the verification process. However, for
freplace programs, the attach type was not propagated along with the
verifier ops, so the expected_attach_type would always be zero for freplace
programs.

This in turn caused the verifier to sometimes make the wrong call for
freplace programs. For all existing uses of expected_attach_type for this
purpose, the result of this was only false negatives (i.e., freplace
functions would be rejected by the verifier even though they were valid
programs for the target they were replacing). However, should a false
positive be introduced, this can lead to out-of-bounds accesses and/or
crashes.

The fix introduced in this patch is to propagate the expected_attach_type
to the freplace program during verification, and reset it after that is
done.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9382609147f5..fa1d8245b925 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10497,6 +10497,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 			env->ops = bpf_verifier_ops[tgt_prog->type];
+			prog->expected_attach_type = tgt_prog->expected_attach_type;
 		}
 		if (!tgt_prog->jited) {
 			verbose(env, "Can attach to only JITed progs\n");
@@ -10841,6 +10842,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		 * them now. Otherwise free_used_maps() will release them.
 		 */
 		release_maps(env);
+
+	/* extension progs temporarily inherit the attach_type of their targets
+	   for verification purposes, so set it back to zero before returning
+	 */
+	if (env->prog->type == BPF_PROG_TYPE_EXT)
+		env->prog->expected_attach_type = 0;
+
 	*prog = env->prog;
 err_unlock:
 	if (!is_priv)


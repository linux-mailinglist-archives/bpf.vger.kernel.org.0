Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8F57BBC5
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiGTQrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiGTQrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 12:47:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491D3B979
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 09:47:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i9-20020a170902cf0900b0016d1e277547so1689473plg.0
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=CuyZwFu1Zt52A3Wtsx8i/O5tRA8Koa3iDRGqsfxSIpI=;
        b=BhE9GERZNtcNyOedKgwn8oLoKN2Twptaodr09mNB69A5qCPyCxw63fkS38+3Za+GLA
         jzUKl0K4xtNAkxHP1EgHoNYFpGrc+8JT7l2pjHUTMI3xaVFsCHcjGZe5EFHzz4ar5MSK
         sEUpobzwYBfM+V9fCupXCAtt0aJjoPRgKKoFetgURIVCq2lVWWn22GhCRAuugXhytPpe
         xqUHmjTrY6efYcAv1Om47GwGehHJAj5jAFS+dEKJ4AuIm2kT4kA6/RlRwpONdLiap2bv
         6nIHKVl3M5oBjt3/om0i8Y6jUzdMLbpYl7vHsQ3N/dGhhhAFd7FybJJmFPv4j6srDBj4
         imNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=CuyZwFu1Zt52A3Wtsx8i/O5tRA8Koa3iDRGqsfxSIpI=;
        b=R0fPVdH3irE+0uVJb64kwJuuakJpX5UnswC4s+ouDYjV7lPoslxPMO8a58+X1c2PME
         otwGjoRI7Jce2qNBn6+MrAnyxOjOtQ6ejXJCJEV8PO4JRv30LF1us4ldSrIr2+ZsrGAh
         uwx9b0wsuelU3dqUjXhJ1Turqf4sTvQyJuQHdeYCAH6zbrvHfSyGaMUavUOHUknkDI5U
         CNRq/8dTVARljqbaCehLx5woAKFhJgpF9tRPWlVu5SI8hE1F5nTKSkXZS0rNPDSXqkkN
         DCprJEyxo0yboBqmFpRBSLplGk0Pg8dcn2ZAlMjjlnNKH0BOBuW1xukRBLJ8dWPwzAfB
         PKIQ==
X-Gm-Message-State: AJIora+7czN2pH1VGdM1JcfcYhtMrozHf75/LbllhyX+ikwdpwyKj3Oy
        6zAbfVeOAxTI4rIBnAv027KShhYAicu71ZyIH3AF5RrJL4l3fiY6IXm9a/LPJwtzZVwFqIrRXsm
        dcEKvAtd/DjBoD/B+pm+ypG9vuTqlxN+3HsKFAktng1wvfzKIIg==
X-Google-Smtp-Source: AGRyM1uNgIbZO2ClIxpdtnZQcCbqVwBIcAR4vGqnkM2A2F5UaBYoc5h6407XU3FR0mfzmWQoZx2q6DI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1a8c:b0:52b:3eed:13d8 with SMTP id
 e12-20020a056a001a8c00b0052b3eed13d8mr28985692pfv.74.1658335650820; Wed, 20
 Jul 2022 09:47:30 -0700 (PDT)
Date:   Wed, 20 Jul 2022 09:47:29 -0700
Message-Id: <20220720164729.147544-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH bpf-next] bpf: Check attach_func_proto more carefully in check_helper_call
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+0f8d989b1fba1addc5e0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller found a problem similar to d1a6edecc1fd ("bpf: Check
attach_func_proto more carefully in check_return_code") where
attach_func_proto might be NULL:

RIP: 0010:check_helper_call+0x3dcb/0x8d50 kernel/bpf/verifier.c:7330
 do_check kernel/bpf/verifier.c:12302 [inline]
 do_check_common+0x6e1e/0xb980 kernel/bpf/verifier.c:14610
 do_check_main kernel/bpf/verifier.c:14673 [inline]
 bpf_check+0x661e/0xc520 kernel/bpf/verifier.c:15243
 bpf_prog_load+0x11ae/0x1f80 kernel/bpf/syscall.c:2620

With the following reproducer:

  bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000780)=3D{0xf, 0x4, &(0x=
7f0000000040)=3D@framed=3D{{}, [@call=3D{0x85, 0x0, 0x0, 0xbb}]}, &(0x7f000=
0000000)=3D'GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xfffffff=
fffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)

Let's do the same here, only check attach_func_proto for the prog types
where we are certain that attach_func_proto is defined.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: syzbot+0f8d989b1fba1addc5e0@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c59c3df0fea6..7c1e056624f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7170,6 +7170,7 @@ static void update_loop_inline_state(struct bpf_verif=
ier_env *env, u32 subprogno
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			     int *insn_idx_p)
 {
+	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	const struct bpf_func_proto *fn =3D NULL;
 	enum bpf_return_type ret_type;
 	enum bpf_type_flag ret_flag;
@@ -7331,7 +7332,8 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_set_retval:
-		if (env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP) {
+		if (prog_type =3D=3D BPF_PROG_TYPE_LSM &&
+		    env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP) {
 			if (!env->prog->aux->attach_func_proto->type) {
 				/* Make sure programs that attach to void
 				 * hooks don't try to modify return value.
--=20
2.37.0.170.g444d1eabd0-goog


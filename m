Return-Path: <bpf+bounces-62461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A083AF9DE7
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 04:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77C454620A
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFDD28ECEF;
	Sat,  5 Jul 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V12NaXgJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757A2750EA
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751683671; cv=none; b=T9LCR+Bd+u8SCO4Lot6bayMaUlEhoTgb6oHJfNWbkmRVXrE7pQO/0/MMe036ZXDzrN6nStdC1MQjCJxmrXydXwbN9WAACbGTlAVP3+pK2KmPMjJ+CfyemYMUgG+zQLc0+ztpgatJnnO8ek3EaqvnhUXMnE0XLHVxVZY+57JAqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751683671; c=relaxed/simple;
	bh=cc0iQtLpF+UnzUYQsRkkuGF5cyUzkqUW6ENo747T6O0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=aE+9AVmSpo8Uz8Od7dpQs5Kzw7b/r+d1y5Y8nLD4j4HP4HIIYk7bgqu3GVf5hXM61XlzYEMSmPsPkdr7Pk3ts1fxaT1LEg6qwO1Y3Ikqod4ddUHq5GfPpr/rAHYT9uOnTnkodKiKrdbuj6btKQUg+ax91UHR6eMp05EVzOBRhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V12NaXgJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1326165a12.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751683668; x=1752288468; darn=vger.kernel.org;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ae5bmwKrjQ/PM7+hA02W5KHN6pBZJA9Jv5epBM2iqMo=;
        b=V12NaXgJQqq0ltoDh8BebLGq3txW6tOQ3y5ca17EXeb/2oEJpLgm/9UoliKcWKGNVN
         PYzjtu1ydT+qVfYaBMm1VwgQfZFHz9K2AM+d3tWuainMuUB8LTF8UDNW8192Ytbk+i+y
         KKRlPPduJTm30NiMzRXbt8Crg5S7RZCVIfD9bsTe9njosphj+bH/yCuivLJEAJ4zbagt
         bKcXq97FdWHKRr9rwr8ohsUWi64+ALLu9E+AyurISZlVDh7hOi4xo4x3lgYsA7NSHqH1
         tUDR6EEjoekgReXu90uqOxQkO64zCTcrabQxmZL9DJ46prcMgxdcqcZ0AXx4rL3t06dI
         IcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751683668; x=1752288468;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ae5bmwKrjQ/PM7+hA02W5KHN6pBZJA9Jv5epBM2iqMo=;
        b=nTfhiW6zj9DwvqqO1L5uUfOXB/HraGStL9ffQDnf7ujI+PBuxMF55VFWjXhXBythgs
         pPEBFLaKDViV6w1BYALCgITA1S4+491tUpJJtXBi9y4yrzU8L/QkrGmxa0IFfkMsrK7M
         uOZgeK8pv1wS5VpC4RqeHtqMVyWNT7rxTy0ho1E7/qp8lwGq3GGOPrOvPUNEAep1dtWB
         FZM5BGsfXaBgJ2/hGh8+XJIKBAszaXI3eMJpJdr3nofYvEu5Y1Q9S1y4NGBD7mwjbuGK
         eOFJulYuapigt8cr/hkoRJy5mG2OTA1KZX4kIJyhXnvcct2QibjoN4RsWAIET1TPLsGH
         ehiw==
X-Gm-Message-State: AOJu0YwyqlSwNhgZ3t6YEZ2sd8UQcDy9YxV44WSF280/tMIXLJKb3Bc3
	jVJeeEXM/dnhGlqmc585WNUMvHZ428wKvJDAypR3O0VzUO0hDobS2M4SkVGdHA==
X-Gm-Gg: ASbGncs3pigILKNsNfoz2zMMsQDExsNeCjYIKKlu766PuA7Jfb1FZJZGAn2CjRHYf3h
	PS1hP/CoFfL/HwY4YfYpK4uiPkA2TojObPNmaNf5/0WQtjHIMLuxWEb9skWztQDlsFoGO+Qiv2Y
	8/XAlzq2L0vSNJhbaPz+DSI+IVRFIzJuNMe4h7wXHjwy+8MQdN+6OZM0btt/hJDT0AwG0++CVGY
	Utl9D4PARjVDQewzwVa44723w1zYW4/sVffBjlycVRg8+DlXkPp6GpoAJ9NWrZr+ux+NrPvXBsi
	d74E13fsK6gQFhzoeKagMzngRSQqmZUBGgccJvTjPYTzsF+BZ86e3Z0fNA==
X-Google-Smtp-Source: AGHT+IG5Yqumv+DmLaNkRc5X6tmompfd0z7bPFEQu1bq70xBShhcwVgKEBadKo9zNGB6rxdbX1tBmA==
X-Received: by 2002:a17:902:f54e:b0:234:f580:9f5 with SMTP id d9443c01a7336-23c90f93589mr9335145ad.9.1751683667937;
        Fri, 04 Jul 2025 19:47:47 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a39bsm30390815ad.21.2025.07.04.19.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 19:47:47 -0700 (PDT)
Message-ID: <f3527af3b0620ce36e299e97e7532d2555018de2.camel@gmail.com>
Subject: KASAN error in core.c:bpf_prog_get_file_line()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Date: Fri, 04 Jul 2025 19:47:45 -0700
Content-Type: multipart/mixed; boundary="=-Hi+jqv2vmo/6o9jRkkAn"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-Hi+jqv2vmo/6o9jRkkAn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

I hit a KASAN error when running verifier_iterating_callbacks/ja_and_may_go=
to_subprog test case.
(CC'ing mailing list in case anyone else runs into it before fix).
The error is within the function kernel/bpf/core.c:bpf_prog_get_file_line()=
:


  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const=
 char **filep,
                             const char **linep, int *nump)
  {
        ...
        struct bpf_line_info *linfo;
        ...
        linfo =3D prog->aux->linfo;
        ...
        linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
        ...
        for (int i =3D 0; i < prog->aux->nr_linfo &&
--->         linfo[i].insn_off >=3D insn_start && linfo[i].insn_off < insn_=
end; i++) {
                if (jited_linfo[i] >=3D (void *)ip)
                        break;
                idx =3D i;
        }
        ...
  }

The error is reported at the marked line. Full report is in the
attachment, main part is here:

[    2.457680] BUG: KASAN: slab-out-of-bounds in bpf_prog_get_file_line (ke=
rnel/bpf/core.c:3263 (discriminator 2))=20
...
[    2.458068] ? bpf_prog_get_file_line (kernel/bpf/core.c:3263 (discrimina=
tor 2))=20
[    2.458074] bpf_prog_get_file_line (kernel/bpf/core.c:3263 (discriminato=
r 2))=20
[    2.458078] ? bpf_prog_0b95dbe6b5c648f2_subprog_with_may_goto+0x49/0x57=
=20
[    2.466754] Allocated by task 150:
...
[    2.467122] check_btf_line (./include/linux/slab.h:1065 kernel/bpf/verif=
ier.c:18118)=20
[    2.467190] bpf_check (kernel/bpf/verifier.c:18332 kernel/bpf/verifier.c=
:24611)=20
[    2.467258] bpf_prog_load (kernel/bpf/syscall.c:2972 (discriminator 1))=
=20
[    2.467325] __sys_bpf (kernel/bpf/syscall.c:6007)=20
[    2.467392] __x64_sys_bpf (kernel/bpf/syscall.c:6115)=20
[    2.467459] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator=
 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))=20
[    2.467527] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:13=
0)=20
[    2.467615]=20
[    2.467660] The buggy address belongs to the object at ffff888107f8f980
[    2.467660]  which belongs to the cache kmalloc-cg-32 of size 32
[    2.467873] The buggy address is located 0 bytes to the right of
[    2.467873]  allocated 32-byte region [ffff888107f8f980, ffff888107f8f9a=
0)
[    2.468094]=20

Note the following part of the verifier.c:jit_subprogs:

  static int jit_subprogs(struct bpf_verifier_env *env)
  {
        ...
        for (i =3D 0; i < env->subprog_cnt; i++) {
                ...
                func[i]->aux->linfo =3D prog->aux->linfo;
                func[i]->aux->nr_linfo =3D prog->aux->nr_linfo;
                ...
                func[i]->aux->linfo_idx =3D env->subprog_info[i].linfo_idx;
                ...
  }

Given the above initialization, I think bpf_prog_get_file_line() has
to be fixed as follows:

--- 8< -------------------------------------------

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fe8a53f3c5bc..061ff34e0f53 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3253,13 +3253,13 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, u=
nsigned long ip, const char *
                return -EINVAL;
        len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len=
 : prog->len;
=20
-       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
-       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
+       linfo =3D prog->aux->linfo;
+       jited_linfo =3D prog->aux->jited_linfo;
=20
        insn_start =3D linfo[0].insn_off;
        insn_end =3D insn_start + len;
=20
-       for (int i =3D 0; i < prog->aux->nr_linfo &&
+       for (int i =3D prog->aux->linfo_idx; i < prog->aux->nr_linfo &&
             linfo[i].insn_off >=3D insn_start && linfo[i].insn_off < insn_=
end; i++) {
                if (jited_linfo[i] >=3D (void *)ip)
                        break;

------------------------------------------- >8 ---

Could you please take a look?

--=-Hi+jqv2vmo/6o9jRkkAn
Content-Disposition: attachment; filename="kasan-error.decoded"
Content-Transfer-Encoding: base64
Content-Type: text/plain; name="kasan-error.decoded"; charset="UTF-8"

WyAgICAyLjQ1NzUwOF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ClsgICAgMi40NTc2ODBdIEJVRzogS0FTQU46IHNsYWIt
b3V0LW9mLWJvdW5kcyBpbiBicGZfcHJvZ19nZXRfZmlsZV9saW5lIChrZXJuZWwvYnBmL2NvcmUu
YzozMjYzIChkaXNjcmltaW5hdG9yIDIpKSAKWyAgICAyLjQ1NzgzOF0gUmVhZCBvZiBzaXplIDQg
YXQgYWRkciBmZmZmODg4MTA3ZjhmOWEwIGJ5IHRhc2sgdGVzdF9wcm9ncy8xNTAKWyAgICAyLjQ1
Nzk2N10gClsgICAgMi40NTgwMzVdIFRhaW50ZWQ6IFtPXT1PT1RfTU9EVUxFLCBbRV09VU5TSUdO
RURfTU9EVUxFClsgICAgMi40NTgwMzddIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMg
KFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy00LmZjNDIgMDQvMDEvMjAxNApbICAgIDIu
NDU4MDM4XSBDYWxsIFRyYWNlOgpbICAgIDIuNDU4MDQwXSAgPFRBU0s+ClsgICAgMi40NTgwNDJd
IGR1bXBfc3RhY2tfbHZsIChsaWIvZHVtcF9zdGFjay5jOjEyMikgClsgICAgMi40NTgwNDhdIHBy
aW50X3JlcG9ydCAobW0va2FzYW4vcmVwb3J0LmM6NDA5IG1tL2thc2FuL3JlcG9ydC5jOjUyMSkg
ClsgICAgMi40NTgwNTJdID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsgKGFyY2gveDg2L2xpYi9y
ZXRwb2xpbmUuUzoxODMpIApbICAgIDIuNDU4MDU1XSA/IF9fdmlydF9hZGRyX3ZhbGlkICguL2lu
Y2x1ZGUvbGludXgvcmN1cGRhdGUuaDo5NTUgKGRpc2NyaW1pbmF0b3IgMykgLi9pbmNsdWRlL2xp
bnV4L21tem9uZS5oOjIxNjggKGRpc2NyaW1pbmF0b3IgMykgYXJjaC94ODYvbW0vcGh5c2FkZHIu
Yzo2NSAoZGlzY3JpbWluYXRvciAzKSkgClsgICAgMi40NTgwNjBdID8gYnBmX3Byb2dfZ2V0X2Zp
bGVfbGluZSAoa2VybmVsL2JwZi9jb3JlLmM6MzI2MyAoZGlzY3JpbWluYXRvciAyKSkgClsgICAg
Mi40NTgwNjJdIGthc2FuX3JlcG9ydCAobW0va2FzYW4vcmVwb3J0LmM6MjIxIG1tL2thc2FuL3Jl
cG9ydC5jOjYzNikgClsgICAgMi40NTgwNjhdID8gYnBmX3Byb2dfZ2V0X2ZpbGVfbGluZSAoa2Vy
bmVsL2JwZi9jb3JlLmM6MzI2MyAoZGlzY3JpbWluYXRvciAyKSkgClsgICAgMi40NTgwNzRdIGJw
Zl9wcm9nX2dldF9maWxlX2xpbmUgKGtlcm5lbC9icGYvY29yZS5jOjMyNjMgKGRpc2NyaW1pbmF0
b3IgMikpIApbICAgIDIuNDU4MDc4XSA/IGJwZl9wcm9nXzBiOTVkYmU2YjVjNjQ4ZjJfc3VicHJv
Z193aXRoX21heV9nb3RvKzB4NDkvMHg1NyAKWyAgICAyLjQ1ODA4Ml0gPyBicGZfcHJvZ18wYjk1
ZGJlNmI1YzY0OGYyX3N1YnByb2dfd2l0aF9tYXlfZ290bysweDQ5LzB4NTcgClsgICAgMi40NTgw
ODVdIGR1bXBfc3RhY2tfY2IgKGtlcm5lbC9icGYvc3RyZWFtLmM6NDk4KSAKWyAgICAyLjQ1ODA4
N10gPyBmaW5kX2hlbGRfbG9jayAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjUzNTMgKGRpc2Ny
aW1pbmF0b3IgMSkpIApbICAgIDIuNDU4MDkxXSA/IF9fcGZ4X2R1bXBfc3RhY2tfY2IgKGtlcm5l
bC9icGYvc3RyZWFtLmM6NDg3KSAKWyAgICAyLjQ1ODA5NF0gPyBfX3BmeF9kdW1wX3N0YWNrX2Ni
IChrZXJuZWwvYnBmL3N0cmVhbS5jOjQ4NykgClsgICAgMi40NTgwOTZdID8gc3Jzb19hbGlhc19y
ZXR1cm5fdGh1bmsgKGFyY2gveDg2L2xpYi9yZXRwb2xpbmUuUzoxODMpIApbICAgIDIuNDU4MDk3
XSA/IGxvY2tfcmVsZWFzZSAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ3MyAoZGlzY3JpbWlu
YXRvciA2KSBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTg5NCAoZGlzY3JpbWluYXRvciA2KSBr
ZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTg3OCAoZGlzY3JpbWluYXRvciA2KSkgClsgICAgMi40
NTgxMDJdID8gaXNfYnBmX3RleHRfYWRkcmVzcyAoa2VybmVsL2JwZi9jb3JlLmM6NzgxKSAKWyAg
ICAyLjQ1ODEwNF0gPyBzcnNvX2FsaWFzX3JldHVybl90aHVuayAoYXJjaC94ODYvbGliL3JldHBv
bGluZS5TOjE4MykgClsgICAgMi40NTgxMDZdID8ga2VybmVsX3RleHRfYWRkcmVzcyAoa2VybmVs
L2V4dGFibGUuYzoxMjUgKGRpc2NyaW1pbmF0b3IgMSkga2VybmVsL2V4dGFibGUuYzo5NCAoZGlz
Y3JpbWluYXRvciAxKSkgClsgICAgMi40NTgxMTJdID8gYnBmX3Byb2dfMGI5NWRiZTZiNWM2NDhm
Ml9zdWJwcm9nX3dpdGhfbWF5X2dvdG8rMHg0OS8weDU3IApbICAgIDIuNDU4MTE0XSA/IHNyc29f
YWxpYXNfcmV0dXJuX3RodW5rIChhcmNoL3g4Ni9saWIvcmV0cG9saW5lLlM6MTgzKSAKWyAgICAy
LjQ1ODExN10gPyBfX3BmeF9kdW1wX3N0YWNrX2NiIChrZXJuZWwvYnBmL3N0cmVhbS5jOjQ4Nykg
ClsgICAgMi40NTgxMTldIGFyY2hfYnBmX3N0YWNrX3dhbGsgKGFyY2gveDg2L25ldC9icGZfaml0
X2NvbXAuYzozODQzIChkaXNjcmltaW5hdG9yIDEpKSAKWyAgICAyLjQ1ODEyM10gPyBfX3BmeF9h
cmNoX2JwZl9zdGFja193YWxrIChhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmM6MzgzNSkgClsg
ICAgMi40NTgxMjddID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsgKGFyY2gveDg2L2xpYi9yZXRw
b2xpbmUuUzoxODMpIApbICAgIDIuNDU4MTI5XSA/IGxvY2tkZXBfaGFyZGlycXNfb25fcHJlcGFy
ZSAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ3MyAoZGlzY3JpbWluYXRvciA2KSBrZXJuZWwv
bG9ja2luZy9sb2NrZGVwLmM6NDQxNCAoZGlzY3JpbWluYXRvciA2KSBrZXJuZWwvbG9ja2luZy9s
b2NrZGVwLmM6NDM2NSAoZGlzY3JpbWluYXRvciA2KSkgClsgICAgMi40NTgxMzVdID8gYnBmX3By
b2dfMGI5NWRiZTZiNWM2NDhmMl9zdWJwcm9nX3dpdGhfbWF5X2dvdG8rMHg0OS8weDU3IApbICAg
IDIuNDU4MTM4XSA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rIChhcmNoL3g4Ni9saWIvcmV0cG9s
aW5lLlM6MTgzKSAKWyAgICAyLjQ1ODE0MV0gPyBicGZfc3RyZWFtX3N0YWdlX3ByaW50ayAoLi9p
bmNsdWRlL2xpbnV4L2xsaXN0Lmg6MjQyIChkaXNjcmltaW5hdG9yIDIwKSAuL2luY2x1ZGUvbGlu
dXgvbGxpc3QuaDoyNjUgKGRpc2NyaW1pbmF0b3IgMjApIGtlcm5lbC9icGYvc3RyZWFtLmM6MTk1
IChkaXNjcmltaW5hdG9yIDIwKSBrZXJuZWwvYnBmL3N0cmVhbS5jOjQ0OCAoZGlzY3JpbWluYXRv
ciAyMCkpIApbICAgIDIuNDU4MTQ1XSBicGZfc3RyZWFtX3N0YWdlX2R1bXBfc3RhY2sgKGtlcm5l
bC9icGYvc3RyZWFtLmM6NTIzKSAKWyAgICAyLjQ1ODE0OF0gPyBfX3BmeF9icGZfc3RyZWFtX3N0
YWdlX2R1bXBfc3RhY2sgKGtlcm5lbC9icGYvc3RyZWFtLmM6NTEwKSAKWyAgICAyLjQ1ODE1MV0g
PyBfX2xvY2tfYWNxdWlyZSAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ2NzcgKGRpc2NyaW1p
bmF0b3IgMSkga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjUxOTQgKGRpc2NyaW1pbmF0b3IgMSkp
IApbICAgIDIuNDU4MTU2XSBicGZfcHJvZ19yZXBvcnRfbWF5X2dvdG9fdmlvbGF0aW9uIChrZXJu
ZWwvYnBmL2NvcmUuYzozMTgwIChkaXNjcmltaW5hdG9yIDMpKSAKWyAgICAyLjQ1ODE1OV0gPyBf
X3BmeF9icGZfcHJvZ19yZXBvcnRfbWF5X2dvdG9fdmlvbGF0aW9uIChrZXJuZWwvYnBmL2NvcmUu
YzozMTcyKSAKWyAgICAyLjQ1ODE2MV0gPyBzcnNvX2FsaWFzX3JldHVybl90aHVuayAoYXJjaC94
ODYvbGliL3JldHBvbGluZS5TOjE4MykgClsgICAgMi40NTgxNjRdID8gbG9ja2RlcF9oYXJkaXJx
c19vbiAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ0NzYpIApbICAgIDIuNDU4MTY3XSA/IHNy
c29fYWxpYXNfcmV0dXJuX3RodW5rIChhcmNoL3g4Ni9saWIvcmV0cG9saW5lLlM6MTgzKSAKWyAg
ICAyLjQ1ODE2OV0gPyBhc21fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0ICguL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2lkdGVudHJ5Lmg6NzAyKSAKWyAgICAyLjQ1ODE3Ml0gPyBrdGltZV9nZXRf
bW9ub19mYXN0X25zIChrZXJuZWwvdGltZS90aW1la2VlcGluZy5jOjI1MSBrZXJuZWwvdGltZS90
aW1la2VlcGluZy5jOjM2MCBrZXJuZWwvdGltZS90aW1la2VlcGluZy5jOjQwOCBrZXJuZWwvdGlt
ZS90aW1la2VlcGluZy5jOjQ0OCkgClsgICAgMi40NTgxNzddIGJwZl9jaGVja190aW1lZF9tYXlf
Z290byAoa2VybmVsL2JwZi9jb3JlLmM6MzE5OSkgClsgICAgMi40NTgxODBdIGFyY2hfYnBmX3Rp
bWVkX21heV9nb3RvIChhcmNoL3g4Ni9uZXQvYnBmX3RpbWVkX21heV9nb3RvLlM6NDMpIApbICAg
IDIuNDU4MTg0XSAgPyAweGZmZmZmZmZmYzAwMDA2ZDQKWyAgICAyLjQ1ODE4N10gYnBmX3Byb2df
MGI5NWRiZTZiNWM2NDhmMl9zdWJwcm9nX3dpdGhfbWF5X2dvdG8rMHg0OS8weDU3IApbICAgIDIu
NDU4MTkwXSBicGZfcHJvZ19hYmExZThhZThjMjhlNmFmX2phX2FuZF9tYXlfZ290b19zdWJwcm9n
KzB4MTkvMHgxZiAKWyAgICAyLjQ1ODE5M10gYnBmX3Rlc3RfcnVuICguL2luY2x1ZGUvbGludXgv
YnBmLmg6MTMyMiAuL2luY2x1ZGUvbGludXgvZmlsdGVyLmg6NzE4IC4vaW5jbHVkZS9saW51eC9m
aWx0ZXIuaDo3MjUgbmV0L2JwZi90ZXN0X3J1bi5jOjQzNCkgClsgICAgMi40NTgxOThdID8gYnBm
X3Rlc3RfcnVuICguL2luY2x1ZGUvbGludXgvYm90dG9tX2hhbGYuaDoyMCAoZGlzY3JpbWluYXRv
ciAxKSBuZXQvYnBmL3Rlc3RfcnVuLmM6NDI4IChkaXNjcmltaW5hdG9yIDEpKSAKWyAgICAyLjQ1
ODIwM10gPyBfX3BmeF9icGZfdGVzdF9ydW4gKG5ldC9icGYvdGVzdF9ydW4uYzo0MDIpIApbICAg
IDIuNDU4MjE4XSA/IF9fcGZ4X2V0aF90eXBlX3RyYW5zIChuZXQvZXRoZXJuZXQvZXRoLmM6MTU2
KSAKWyAgICAyLjQ1ODIyMV0gPyBzcnNvX2FsaWFzX3JldHVybl90aHVuayAoYXJjaC94ODYvbGli
L3JldHBvbGluZS5TOjE4MykgClsgICAgMi40NTgyMjNdID8ga3NtX3Byb2Nlc3NfbWVyZ2VhYmxl
IChtbS9rc20uYzozMjc5KSAKWyAgICAyLjQ1ODIyOF0gYnBmX3Byb2dfdGVzdF9ydW5fc2tiIChu
ZXQvYnBmL3Rlc3RfcnVuLmM6MTA5OSkgClsgICAgMi40NTgyMzBdID8gc3Jzb19hbGlhc19yZXR1
cm5fdGh1bmsgKGFyY2gveDg2L2xpYi9yZXRwb2xpbmUuUzoxODMpIApbICAgIDIuNDU4MjMyXSA/
IGZpbmRfaGVsZF9sb2NrIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTM1MyAoZGlzY3JpbWlu
YXRvciAxKSkgClsgICAgMi40NTgyMzldID8gX19wZnhfYnBmX3Byb2dfdGVzdF9ydW5fc2tiIChu
ZXQvYnBmL3Rlc3RfcnVuLmM6OTg2KSAKWyAgICAyLjQ1ODI0NF0gPyBzcnNvX2FsaWFzX3JldHVy
bl90aHVuayAoYXJjaC94ODYvbGliL3JldHBvbGluZS5TOjE4MykgClsgICAgMi40NTgyNDZdID8g
ZnB1dCAoLi9pbmNsdWRlL2xpbnV4L3ByZWVtcHQuaDo0ODEgKGRpc2NyaW1pbmF0b3IgNSkgLi9p
bmNsdWRlL2xpbnV4L2ZpbGVfcmVmLmg6MTUwIChkaXNjcmltaW5hdG9yIDUpIGZzL2ZpbGVfdGFi
bGUuYzo1NDEgKGRpc2NyaW1pbmF0b3IgNSkpIApbICAgIDIuNDU4MjUyXSBfX3N5c19icGYgKGtl
cm5lbC9icGYvc3lzY2FsbC5jOjQ1Nzgga2VybmVsL2JwZi9zeXNjYWxsLmM6NjAyNSkgClsgICAg
Mi40NTgyNTZdID8gX19wZnhfX19zeXNfYnBmIChrZXJuZWwvYnBmL3N5c2NhbGwuYzo1OTY5KSAK
WyAgICAyLjQ1ODI1OF0gPyBzcnNvX2FsaWFzX3JldHVybl90aHVuayAoYXJjaC94ODYvbGliL3Jl
dHBvbGluZS5TOjE4MykgClsgICAgMi40NTgyNjBdID8gbXRfZmluZCAobGliL21hcGxlX3RyZWUu
Yzo2OTM4IChkaXNjcmltaW5hdG9yIDEpKSAKWyAgICAyLjQ1ODI2NV0gPyBzcnNvX2FsaWFzX3Jl
dHVybl90aHVuayAoYXJjaC94ODYvbGliL3JldHBvbGluZS5TOjE4MykgClsgICAgMi40NTgyNjdd
ID8gbG9ja19hY3F1aXJlIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDczIGtlcm5lbC9sb2Nr
aW5nL2xvY2tkZXAuYzo1ODczIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo1ODI4KSAKWyAgICAy
LjQ1ODI2OV0gPyBfX21pZ2h0X2ZhdWx0IChtbS9tZW1vcnkuYzo2OTcxIChkaXNjcmltaW5hdG9y
IDQpKSAKWyAgICAyLjQ1ODI3M10gPyBzcnNvX2FsaWFzX3JldHVybl90aHVuayAoYXJjaC94ODYv
bGliL3JldHBvbGluZS5TOjE4MykgClsgICAgMi40NTgyNzVdID8gbG9ja19hY3F1aXJlIChrZXJu
ZWwvbG9ja2luZy9sb2NrZGVwLmM6NDczIChkaXNjcmltaW5hdG9yIDYpIGtlcm5lbC9sb2NraW5n
L2xvY2tkZXAuYzo1ODczIChkaXNjcmltaW5hdG9yIDYpIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAu
Yzo1ODI4IChkaXNjcmltaW5hdG9yIDYpKSAKWyAgICAyLjQ1ODI4NF0gPyBfX3BmeF9fX3VwX3Jl
YWQgKGtlcm5lbC9sb2NraW5nL3J3c2VtLmM6MTMzNykgClsgICAgMi40NTgyODhdID8gX19wZnhf
X19yc2VxX2hhbmRsZV9ub3RpZnlfcmVzdW1lIChrZXJuZWwvcnNlcS5jOjQyNSkgClsgICAgMi40
NTgyOTFdID8gX19wZnhfZnB1dF9jbG9zZV9zeW5jIChmcy9maWxlX3RhYmxlLmM6NTY4KSAKWyAg
ICAyLjQ1ODI5N10gX194NjRfc3lzX2JwZiAoa2VybmVsL2JwZi9zeXNjYWxsLmM6NjExNSkgClsg
ICAgMi40NTgyOTldID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsgKGFyY2gveDg2L2xpYi9yZXRw
b2xpbmUuUzoxODMpIApbICAgIDIuNDU4MzAxXSA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rIChh
cmNoL3g4Ni9saWIvcmV0cG9saW5lLlM6MTgzKSAKWyAgICAyLjQ1ODMwM10gPyBsb2NrZGVwX2hh
cmRpcnFzX29uIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDQ3NikgClsgICAgMi40NTgzMDZd
IGRvX3N5c2NhbGxfNjQgKGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo2MyAoZGlzY3JpbWlu
YXRvciAxKSBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6OTQgKGRpc2NyaW1pbmF0b3IgMSkp
IApbICAgIDIuNDU4MzA5XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUgKGFyY2gveDg2
L2VudHJ5L2VudHJ5XzY0LlM6MTMwKSAKWyAgICAyLjQ1ODMxMl0gUklQOiAwMDMzOjB4N2YyM2Ex
MmZmYThkClsgMi40NTgzMTRdIENvZGU6IGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAw
IDAwIDkwIGYzIDBmIDFlIGZhIDQ4IDg5IGY4IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRk
IDg5IGMyIDRkIDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYg
NzMgMDEgYzMgNDggOGIgMGQgNGIgNjMgMGYgMDAgZjcgZDggNjQgODkgMDEgNDgKQWxsIGNvZGUK
PT09PT09PT0KICAgMDoJZmYgYzMgICAgICAgICAgICAgICAgCWluYyAgICAlZWJ4CiAgIDI6CTY2
IDJlIDBmIDFmIDg0IDAwIDAwIAljcyBub3B3IDB4MCglcmF4LCVyYXgsMSkKICAgOToJMDAgMDAg
MDAgCiAgIGM6CTkwICAgICAgICAgICAgICAgICAgIAlub3AKICAgZDoJZjMgMGYgMWUgZmEgICAg
ICAgICAgCWVuZGJyNjQKICAxMToJNDggODkgZjggICAgICAgICAgICAgCW1vdiAgICAlcmRpLCVy
YXgKICAxNDoJNDggODkgZjcgICAgICAgICAgICAgCW1vdiAgICAlcnNpLCVyZGkKICAxNzoJNDgg
ODkgZDYgICAgICAgICAgICAgCW1vdiAgICAlcmR4LCVyc2kKICAxYToJNDggODkgY2EgICAgICAg
ICAgICAgCW1vdiAgICAlcmN4LCVyZHgKICAxZDoJNGQgODkgYzIgICAgICAgICAgICAgCW1vdiAg
ICAlcjgsJXIxMAogIDIwOgk0ZCA4OSBjOCAgICAgICAgICAgICAJbW92ICAgICVyOSwlcjgKICAy
MzoJNGMgOGIgNGMgMjQgMDggICAgICAgCW1vdiAgICAweDgoJXJzcCksJXI5CiAgMjg6CTBmIDA1
ICAgICAgICAgICAgICAgIAlzeXNjYWxsCiAgMmE6Kgk0OCAzZCAwMSBmMCBmZiBmZiAgICAJY21w
ICAgICQweGZmZmZmZmZmZmZmZmYwMDEsJXJheAkJPC0tIHRyYXBwaW5nIGluc3RydWN0aW9uCiAg
MzA6CTczIDAxICAgICAgICAgICAgICAgIAlqYWUgICAgMHgzMwogIDMyOgljMyAgICAgICAgICAg
ICAgICAgICAJcmV0CiAgMzM6CTQ4IDhiIDBkIDRiIDYzIDBmIDAwIAltb3YgICAgMHhmNjM0Yigl
cmlwKSwlcmN4ICAgICAgICAjIDB4ZjYzODUKICAzYToJZjcgZDggICAgICAgICAgICAgICAgCW5l
ZyAgICAlZWF4CiAgM2M6CTY0IDg5IDAxICAgICAgICAgICAgIAltb3YgICAgJWVheCwlZnM6KCVy
Y3gpCiAgM2Y6CTQ4ICAgICAgICAgICAgICAgICAgIAlyZXguVwoKQ29kZSBzdGFydGluZyB3aXRo
IHRoZSBmYXVsdGluZyBpbnN0cnVjdGlvbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09CiAgIDA6CTQ4IDNkIDAxIGYwIGZmIGZmICAgIAljbXAgICAgJDB4ZmZmZmZm
ZmZmZmZmZjAwMSwlcmF4CiAgIDY6CTczIDAxICAgICAgICAgICAgICAgIAlqYWUgICAgMHg5CiAg
IDg6CWMzICAgICAgICAgICAgICAgICAgIAlyZXQKICAgOToJNDggOGIgMGQgNGIgNjMgMGYgMDAg
CW1vdiAgICAweGY2MzRiKCVyaXApLCVyY3ggICAgICAgICMgMHhmNjM1YgogIDEwOglmNyBkOCAg
ICAgICAgICAgICAgICAJbmVnICAgICVlYXgKICAxMjoJNjQgODkgMDEgICAgICAgICAgICAgCW1v
diAgICAlZWF4LCVmczooJXJjeCkKICAxNToJNDggICAgICAgICAgICAgICAgICAgCXJleC5XClsg
ICAgMi40NTgzMTZdIFJTUDogMDAyYjowMDAwN2ZmYzI0MmNhY2U4IEVGTEFHUzogMDAwMDAyMDYg
T1JJR19SQVg6IDAwMDAwMDAwMDAwMDAxNDEKWyAgICAyLjQ1ODMxOV0gUkFYOiBmZmZmZmZmZmZm
ZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDA3ZjIzYTEyZmZhOGQKWyAgICAy
LjQ1ODMyMV0gUkRYOiAwMDAwMDAwMDAwMDAwMDUwIFJTSTogMDAwMDdmZmMyNDJjYWQyMCBSREk6
IDAwMDAwMDAwMDAwMDAwMGEKWyAgICAyLjQ1ODMyMl0gUkJQOiAwMDAwN2ZmYzI0MmNhZDAwIFIw
ODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDA3ZmZjMjQyY2FkMjAKWyAgICAyLjQ1ODMyNF0g
UjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDIwNiBSMTI6IDAwMDA3ZmZj
MjQyY2I3MzgKWyAgICAyLjQ1ODMyNV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAzIFIxNDogMDAwMDdm
MjNhMTk0ZTAwMCBSMTU6IDAwMDAwMDAwMDM3NGZlZTAKWyAgICAyLjQ1ODMzM10gIDwvVEFTSz4K
WyAgICAyLjQ1ODMzNF0gClsgICAgMi40NjY3NTRdIEFsbG9jYXRlZCBieSB0YXNrIDE1MDoKWyAg
ICAyLjQ2NjgyMl0ga2FzYW5fc2F2ZV9zdGFjayAobW0va2FzYW4vY29tbW9uLmM6NDgpIApbICAg
IDIuNDY2ODkyXSBrYXNhbl9zYXZlX3RyYWNrIChtbS9rYXNhbi9jb21tb24uYzo2MCAoZGlzY3Jp
bWluYXRvciAxKSBtbS9rYXNhbi9jb21tb24uYzo2OSAoZGlzY3JpbWluYXRvciAxKSkgClsgICAg
Mi40NjY5NTldIF9fa2FzYW5fa21hbGxvYyAobW0va2FzYW4vY29tbW9uLmM6Mzk4KSAKWyAgICAy
LjQ2NzAzMl0gX19rdm1hbGxvY19ub2RlX25vcHJvZiAoLi9pbmNsdWRlL2xpbnV4L2thc2FuLmg6
MjYwIG1tL3NsdWIuYzo0MzI4IG1tL3NsdWIuYzo1MDE1KSAKWyAgICAyLjQ2NzEyMl0gY2hlY2tf
YnRmX2xpbmUgKC4vaW5jbHVkZS9saW51eC9zbGFiLmg6MTA2NSBrZXJuZWwvYnBmL3ZlcmlmaWVy
LmM6MTgxMTgpIApbICAgIDIuNDY3MTkwXSBicGZfY2hlY2sgKGtlcm5lbC9icGYvdmVyaWZpZXIu
YzoxODMzMiBrZXJuZWwvYnBmL3ZlcmlmaWVyLmM6MjQ2MTEpIApbICAgIDIuNDY3MjU4XSBicGZf
cHJvZ19sb2FkIChrZXJuZWwvYnBmL3N5c2NhbGwuYzoyOTcyIChkaXNjcmltaW5hdG9yIDEpKSAK
WyAgICAyLjQ2NzMyNV0gX19zeXNfYnBmIChrZXJuZWwvYnBmL3N5c2NhbGwuYzo2MDA3KSAKWyAg
ICAyLjQ2NzM5Ml0gX194NjRfc3lzX2JwZiAoa2VybmVsL2JwZi9zeXNjYWxsLmM6NjExNSkgClsg
ICAgMi40Njc0NTldIGRvX3N5c2NhbGxfNjQgKGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo2
MyAoZGlzY3JpbWluYXRvciAxKSBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6OTQgKGRpc2Ny
aW1pbmF0b3IgMSkpIApbICAgIDIuNDY3NTI3XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUgKGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MTMwKSAKWyAgICAyLjQ2NzYxNV0gClsgICAg
Mi40Njc2NjBdIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZm
ODg4MTA3ZjhmOTgwClsgICAgMi40Njc2NjBdICB3aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBr
bWFsbG9jLWNnLTMyIG9mIHNpemUgMzIKWyAgICAyLjQ2Nzg3M10gVGhlIGJ1Z2d5IGFkZHJlc3Mg
aXMgbG9jYXRlZCAwIGJ5dGVzIHRvIHRoZSByaWdodCBvZgpbICAgIDIuNDY3ODczXSAgYWxsb2Nh
dGVkIDMyLWJ5dGUgcmVnaW9uIFtmZmZmODg4MTA3ZjhmOTgwLCBmZmZmODg4MTA3ZjhmOWEwKQpb
ICAgIDIuNDY4MDk0XSAKWyAgICAyLjQ2ODEzOV0gVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0
byB0aGUgcGh5c2ljYWwgcGFnZToKWyAgICAyLjQ2ODIyN10gcGFnZTogcmVmY291bnQ6MCBtYXBj
b3VudDowIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4MTA3ZjhmClsg
ICAgMi40NjgzNjFdIGZsYWdzOiAweDJmZmZlMDAwMDAwMDAwMChub2RlPTB8em9uZT0yfGxhc3Rj
cHVwaWQ9MHg3ZmZmKQpbICAgIDIuNDY4NDc0XSBwYWdlX3R5cGU6IGY1KHNsYWIpClsgICAgMi40
Njg1NDZdIHJhdzogMDJmZmZlMDAwMDAwMDAwMCBmZmZmODg4MTAwMDQ5OTAwIGRlYWQwMDAwMDAw
MDAxMjIgMDAwMDAwMDAwMDAwMDAwMApbICAgIDIuNDY4Njc4XSByYXc6IDAwMDAwMDAwMDAwMDAw
MDAgMDAwMDAwMDA4MDQwMDA0MCAwMDAwMDAwMGY1MDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAKWyAg
ICAyLjQ2ODgxMV0gcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0ZWN0
ZWQKWyAgICAyLjQ2ODg5OF0gClsgICAgMi40Njg5NDNdIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhl
IGJ1Z2d5IGFkZHJlc3M6ClsgICAgMi40NjkwMzNdICBmZmZmODg4MTA3ZjhmODgwOiBmYSBmYiBm
YiBmYiBmYyBmYyBmYyBmYyBmYSBmYiBmYiBmYiBmYyBmYyBmYyBmYwpbICAgIDIuNDY5MTY0XSAg
ZmZmZjg4ODEwN2Y4ZjkwMDogZmEgZmIgZmIgZmIgZmMgZmMgZmMgZmMgZmEgZmIgZmIgZmIgZmMg
ZmMgZmMgZmMKWyAgICAyLjQ2OTI5NV0gPmZmZmY4ODgxMDdmOGY5ODA6IDAwIDAwIDAwIDAwIGZj
IGZjIGZjIGZjIGZhIGZiIGZiIGZiIGZjIGZjIGZjIGZjClsgICAgMi40Njk0MjRdICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeClsgICAgMi40Njk1MTJdICBmZmZmODg4MTA3ZjhmYTAw
OiBmYSBmYiBmYiBmYiBmYyBmYyBmYyBmYyBmYSBmYiBmYiBmYiBmYyBmYyBmYyBmYwpbICAgIDIu
NDY5NjQyXSAgZmZmZjg4ODEwN2Y4ZmE4MDogZmEgZmIgZmIgZmIgZmMgZmMgZmMgZmMgZmEgZmIg
ZmIgZmIgZmMgZmMgZmMgZmMKWyAgICAyLjQ2OTc3M10gPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClsgICAgMi40Njk5MTdd
IERpc2FibGluZyBsb2NrIGRlYnVnZ2luZyBkdWUgdG8ga2VybmVsIHRhaW50CiM1MjAvMTggIHZl
cmlmaWVyX2l0ZXJhdGluZ19jYWxsYmFja3MvamFfYW5kX21heV9nb3RvX3N1YnByb2c6T0sKIzUy
MCAgICAgdmVyaWZpZXJfaXRlcmF0aW5nX2NhbGxiYWNrczpPSwpTdW1tYXJ5OiAxLzEgUEFTU0VE
LCAwIFNLSVBQRUQsIDAgRkFJTEVECg==


--=-Hi+jqv2vmo/6o9jRkkAn--


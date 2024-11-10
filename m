Return-Path: <bpf+bounces-44460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE69C31CF
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 12:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876EC1C209A9
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7C155CB3;
	Sun, 10 Nov 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmhPq+S8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2291494B5;
	Sun, 10 Nov 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238699; cv=none; b=MmutgOpsyMhCgwz42omkSaKcv/XQ9Ceh1f4Q1uWF6Wjqnt91/YrhcLa6ZQuOpskUK9T0mQcSQl1/GxPJBp8NNTrph4CsNoYqQ7PgmKxSVRTbydqWJu75z6N+y0F7QVkuVzOmrJTus2DCntWDU9k7oizMWkzjJXwHU0lKEPGd7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238699; c=relaxed/simple;
	bh=9noXOtArVfiSTOWAqGzhvP0coZ1v166jJCMWuMzJbN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KydI6R1RZwTO+duO/LE2OL+se7ym9U3DujfwzncOKdGZaPF2q31h4tNMHE9cXHPGroy8U+IQS5BAdUIebn1STW9/74gzpuP54UzdBSVgfYWtCPLhgwazpumPmx8PJCFgwacc1s+cZc+/+QNSN2cWjohL5lAN9IE+2ibQM+3dKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmhPq+S8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2799071a91.2;
        Sun, 10 Nov 2024 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731238697; x=1731843497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERlhOZDfcomrAZENVvBzEwh7+6UBl5+z4qZorRa+I7c=;
        b=AmhPq+S80eODRFHY9IYQFJEmroz/emgQo9jNA5zzsewezbfAfUWByaQnfiOyaS/w6H
         pnpTEp0Z/fGJviLf1nbpbyrHQ7o1U1ppkEELv0oozJsEp0Ij6L2BaRyrQjkfOdk3px2F
         WWOBW/JtPccVNuTgH5kHHB68d0jOeoJXJGe2rqqgxu3agzDkLqjDsQvCWf7Kgmrv2FwQ
         tc3sKP/wpkU7QtblS+s6LGGTcJzkpGj4hx+QCIW6MSFrNrPRm/nqEAhy4Wi6dEyxy+Dv
         iEMnaI6+jk/Ej+WPWKJ1Z1Ch/BaI08kDfd/868Td0ju+/1PyL2Q/1rfjJ15RZJtoDrVu
         TIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731238697; x=1731843497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERlhOZDfcomrAZENVvBzEwh7+6UBl5+z4qZorRa+I7c=;
        b=oubXWY+8vuAFWQ35C6a8siB2xuT91rr0RusxLFUrrDu0iav1R1N6TwygoHmVEo/4Rb
         IBj5EIALAhgLY8ty4XgVFUq46B+RcsIpNdIY9Kz0bL/GR08QcvywQ3tKXqlu3a7h+rgQ
         09dDS8G6Kqt/q+CS/vOGveyFREhx5DTj9ycfTf6MxZ8ohEKa0RAWTnVZoh0628Mqbac2
         graNm72xT/mOgITDp65Ik22G3OEI79i0IvazCs5x/JcSyNZ7xRzjGsZRSZpTGy0I2j6L
         X+1HDdfg3XmLEiBszPPOusXe59qjKFpo7dEZbRB61xe5HgXmYTfjtyaDv1LjTYCISmiT
         LJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU10D9uGI/5eaB1K2sdcd9XkE1OC7Qp29MMFduG/Dt2pXAPbeetR9sx2/uCboY35xIE7bvVQzriIA==@vger.kernel.org, AJvYcCUCpCqvwOzjTAGDFJP2mjxKY67nuH8harNPlKnGiIGgufldX/7TjBhtS0BmNR4TFlnKkH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0g+nJy1s9ufBY67SKDbizlXcDYtFJAnXu0rhyW5eb2kbMudd1
	mVwR+ciPqBfaHMqKaGWxjipQ9cZ95jiUk2Mj3g2NpcWCaS0lYk8O
X-Google-Smtp-Source: AGHT+IFR9T86OUp7PHdNd0mQrKBILstcAMs0dW5pt/GjzS6jFFsVDjIBYmamBnSrqx+kyeACPLkJLQ==
X-Received: by 2002:a17:90a:e7cb:b0:2e0:853a:af47 with SMTP id 98e67ed59e1d1-2e9b1748068mr13177275a91.33.1731238696461;
        Sun, 10 Nov 2024 03:38:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f8df7sm8749583a91.41.2024.11.10.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 03:38:15 -0800 (PST)
Message-ID: <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alan Maguire
 <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>,  dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, kernel-team@fb.com,  Song Liu <song@kernel.org>
Date: Sun, 10 Nov 2024 03:38:10 -0800
In-Reply-To: <20241108180524.1198900-1-yonghong.song@linux.dev>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
	 <20241108180524.1198900-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 10:05 -0800, Yonghong Song wrote:

[...]

> For one of internal 6.11 kernel, there are 62498 functions in BTF and
> perf_event_read() is not there. With this patch, there are 61552 function=
s
> in BTF and perf_event_read() is included.

Hi Yonghong,

I checked this patch using my local kernel build and do see a
difference in generated funcs: 47756 vs 47721 funcs with and without.
Looking at DWARF for the newly added functions, the do indeed have
DW_OP_entry_value(expected_reg) in their list of locations.

>=20
> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 81 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 24 deletions(-)
>=20
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e0b8c11..1fe44bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1169,34 +1169,67 @@ static bool check_dwarf_locations(Dwarf_Attribute=
 *attr, struct parameter *parm,
>  		return false;
> =20
>  #if _ELFUTILS_PREREQ(0, 157)
> -	/* dwarf_getlocations() handles location lists; here we are
> -	 * only interested in the first expr.
> -	 */
> -	if (dwarf_getlocations(attr, 0, &base, &start, &end,
> -			       &loc.expr, &loc.exprlen) > 0 &&
> -		loc.exprlen !=3D 0) {
> -		expr =3D loc.expr;
> -
> -		switch (expr->atom) {
> -		case DW_OP_reg0 ... DW_OP_reg31:
> -			/* mark parameters that use an unexpected
> -			 * register to hold a parameter; these will
> -			 * be problematic for users of BTF as they
> -			 * violate expectations about register
> -			 * contents.
> +	bool reg_matched =3D false, reg_unmatched =3D false, first_expr_reg =3D=
 false, ret =3D false;
> +	ptrdiff_t offset =3D 0;
> +	int loc_num =3D -1;
> +
> +	while ((offset =3D dwarf_getlocations(attr, offset, &base, &start, &end=
, &loc.expr, &loc.exprlen)) > 0 &&
> +	       loc.exprlen !=3D 0) {
> +		ret =3D true;
> +		loc_num++;
> +
> +		for (int i =3D 0; i < loc.exprlen; i++) {

I'm not sure if you need to iterate every expression in the list.
The list is a stack program, so each expression is a command.

> +			Dwarf_Attribute entry_attr;
> +			Dwarf_Op *entry_ops;
> +			size_t entry_len;
> +
> +			expr =3D &loc.expr[i];
> +			switch (expr->atom) {
> +			case DW_OP_reg0 ... DW_OP_reg31:
> +				/* first location, first expression */
> +				if (loc_num =3D=3D 0 && i =3D=3D 0) {
> +					if (expected_reg >=3D 0) {
> +						if (expected_reg =3D=3D expr->atom) {
> +							reg_matched =3D true;

reg_matched is never really used in conditionals, as everywhere it is
set to 'true' the 'return true' follows.

[...]

> +	if (reg_unmatched)
> +		parm->unexpected_reg =3D 1;
> +	else if (ret && !first_expr_reg)
> +		parm->optimized =3D 1;

It is a bit unfortunate, that parm->optimized is now set in two functions.
What do you think about the simplification as at the end of this email?

Also, it appears there is some bug either in pahole or in libdw's
implementation of dwarf_getlocation(). When I try both your patch-set
and my variant there is a segfault once in a while:

  $ for i in $(seq 1 100); \
    do echo "---> $i"; \
       pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_det=
ached=3D/dev/null vmlinux ; \
    done
  ---> 1
  ...
  ---> 71
  Segmentation fault (core dumped)
  ...

The segfault happens only when -j (multiple threads) is passed.
If pahole is built with sanitizers
(passing -DCMAKE_C_FLAGS=3D"-fsanitize=3Dundefined,address")
the stack trace looks as follows:

AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D2360650=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000=
0000008 (pc 0x7f20bcb29200 bp 0x7f208f7fc110 sp 0x7f208f7fc0b8 T18)
=3D=3D2360650=3D=3DThe signal is caused by a READ memory access.
=3D=3D2360650=3D=3DHint: address points to the zero page.
    #0 0x7f20bcb29200 in maybe_split_for_insert /usr/src/debug/glibc-2.39-2=
2.fc40.x86_64/misc/tsearch.c:228
    #1 0x7f20bcb29465 in __GI___tsearch /usr/src/debug/glibc-2.39-22.fc40.x=
86_64/misc/tsearch.c:358
    #2 0x7f20bcb29465 in __GI___tsearch /usr/src/debug/glibc-2.39-22.fc40.x=
86_64/misc/tsearch.c:290
    #3 0x7f20bd489a51 in tsearch.part.0 (/lib64/libasan.so.8+0x89a51) (Buil=
dId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
    #4 0x7f20bdb07601 in __libdw_intern_expression (/lib64/libdw.so.1+0x356=
01) (BuildId: b06d0f436023c584e2d618f94f530d9e22671078)
    #5 0x7f20bdb09c70 in dwarf_getlocation (/lib64/libdw.so.1+0x37c70) (Bui=
ldId: b06d0f436023c584e2d618f94f530d9e22671078)
    #6 0x4912c4 in parameter__new (/home/eddy/work/dwarves-fork/build/pahol=
e+0x4912c4) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
    #7 0x495bfa in die__process_function (/home/eddy/work/dwarves-fork/buil=
d/pahole+0x495bfa) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
    #8 0x498671 in __die__process_tag (/home/eddy/work/dwarves-fork/build/p=
ahole+0x498671) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
    #9 0x49c692 in die__process_unit (/home/eddy/work/dwarves-fork/build/pa=
hole+0x49c692) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
    #10 0x49cb5f in die__process (/home/eddy/work/dwarves-fork/build/pahole=
+0x49cb5f) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
    #11 0x4a3767 in dwarf_cus__process_cu (/home/eddy/work/dwarves-fork/bui=
ld/pahole+0x4a3767) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
    #12 0x4a3f8f in dwarf_cus__process_cu_thread (/home/eddy/work/dwarves-f=
ork/build/pahole+0x4a3f8f) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa8=
5a)
    #13 0x7f20bd45df95 in asan_thread_start(void*) (/lib64/libasan.so.8+0x5=
df95) (BuildId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
    #14 0x7f20bcaa66d6 in start_thread /usr/src/debug/glibc-2.39-22.fc40.x8=
6_64/nptl/pthread_create.c:447
    #15 0x7f20bcb2a60b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S=
:78

---

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ec8641b..c5c2298 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1157,16 +1157,83 @@ static struct template_parameter_pack *template_par=
ameter_pack__new(Dwarf_Die *d
 	return pack;
 }
=20
+static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
+				      ptrdiff_t offset, Dwarf_Addr *basep,
+				      Dwarf_Addr *startp, Dwarf_Addr *endp,
+				      Dwarf_Op **expr, size_t *exprlen)
+{
+#if _ELFUTILS_PREREQ(0, 157)
+	return dwarf_getlocations(attr, offset, basep, startp, endp, expr, exprle=
n);
+#else
+	int err;
+
+	if (offset)
+		return 0;
+
+	err =3D dwarf_getlocation(attr, expr, exprlen);
+	return err < 0 ? err : 1;
+#endif
+}
+
+/* For DW_AT_location 'attr':
+ * - if first location is DW_OP_regXX with expected number, returns the re=
gister;
+ * - if location DW_OP_entry_value(DW_OP_regXX) is in the list, returns th=
e register;
+ * - if first location is DW_OP_regXX, returns the register;
+ * - otherwise returns -1.
+ */
+static int param_reg_at_entry(Dwarf_Attribute *attr, int expected_reg)
+{
+	Dwarf_Op *expr, *entry_ops, *first_expr =3D NULL;
+	Dwarf_Addr base, start, end;
+	Dwarf_Attribute entry_attr;
+	size_t exprlen, entry_len;
+	ptrdiff_t offset =3D 0;
+        int loc_num =3D -1;
+
+        while ((offset =3D __dwarf_getlocations(attr, offset, &base, &star=
t, &end, &expr, &exprlen)) > 0) {
+		loc_num++;
+
+		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
+		 * DW_OP_stack_value instructs interpreter to pop current value from
+		 * DWARF expression evaluation stack, and thus is not important here.
+		 */
+		if (exprlen > 1 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_value)
+			exprlen--;
+
+		if (exprlen !=3D 1)
+			continue;
+
+		switch (expr->atom) {
+		/* match DW_OP_regXX at first location */
+		case DW_OP_reg0 ... DW_OP_reg31:
+			if (loc_num =3D=3D 0) {
+				if(expr->atom =3D=3D expected_reg)
+					return expr->atom;
+				first_expr =3D expr;
+			}
+		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
+		case DW_OP_entry_value:
+		case DW_OP_GNU_entry_value:
+			if (dwarf_getlocation_attr (attr, expr, &entry_attr) =3D=3D 0 &&
+			    dwarf_getlocation (&entry_attr, &entry_ops, &entry_len) =3D=3D 0 &&
+			    entry_len =3D=3D 1)
+				return entry_ops->atom;
+			break;
+		}
+	}
+	if (first_expr)
+		return first_expr->atom;
+	return -1;
+}
+
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 					struct conf_load *conf, int param_idx)
 {
 	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
=20
 	if (parm !=3D NULL) {
-		Dwarf_Addr base, start, end;
 		bool has_const_value;
 		Dwarf_Attribute attr;
-		struct location loc;
=20
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
@@ -1208,35 +1275,21 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 		 */
 		has_const_value =3D dwarf_attr(die, DW_AT_const_value, &attr) !=3D NULL;
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
-		/* dwarf_getlocations() handles location lists; here we are
-		 * only interested in the first expr.
-		 */
-		if (parm->has_loc &&
-#if _ELFUTILS_PREREQ(0, 157)
-		    dwarf_getlocations(&attr, 0, &base, &start, &end,
-				       &loc.expr, &loc.exprlen) > 0 &&
-#else
-		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) =3D=3D 0 &&
-#endif
-			loc.exprlen !=3D 0) {
+
+		if (parm->has_loc) {
 			int expected_reg =3D cu->register_params[param_idx];
-			Dwarf_Op *expr =3D loc.expr;
+			int actual_reg =3D param_reg_at_entry(&attr, expected_reg);
=20
-			switch (expr->atom) {
-			case DW_OP_reg0 ... DW_OP_reg31:
+			if (actual_reg < 0)
+				parm->optimized =3D 1;
+			else if (expected_reg >=3D 0 && expected_reg !=3D actual_reg)
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
 				 * violate expectations about register
 				 * contents.
 				 */
-				if (expected_reg >=3D 0 && expected_reg !=3D expr->atom)
-					parm->unexpected_reg =3D 1;
-				break;
-			default:
-				parm->optimized =3D 1;
-				break;
-			}
+				parm->unexpected_reg =3D 1;
 		} else if (has_const_value) {
 			parm->optimized =3D 1;
 		}



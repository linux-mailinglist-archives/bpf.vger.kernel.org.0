Return-Path: <bpf+bounces-62242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2D7AF6E18
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E483A1648DB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FC2D4B5B;
	Thu,  3 Jul 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eHHl+LfM"
X-Original-To: bpf@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624C2D0C94;
	Thu,  3 Jul 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533375; cv=none; b=E5++zvrVcNE8i98sX76zN4bQlq/l6Mcp2d5CBq/iyM2p3y/I9BrBkTsAShQ8kOtNpH5t62PddFgTj2A4S878yzXav+E1UXQcOtrXb7D0gswC8EkC/y29btFqzYHBxDnW2ENuEJewXras20f8gVh67M2drJ1wOUjxzGQzJjxQqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533375; c=relaxed/simple;
	bh=iOtof3LorJ6XnQW4YlkMb/uYlOtxPWVJ4TAhFcAvVOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdaL53mizbV2mNzv54fh4izuVL60HOpAV4fpY07EKOcy7LJcIklGjsoNGKbHhclIauE9ybllkopsTdKk1bGhpcI6JRGSwJw+kE2SF8wDXVqECp0blKUxE8zfH1CscIu7RyFmFn+eyahjrw7fJL0vOeQmY6cht5QkD5FrRE9QaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eHHl+LfM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9FFD41D02;
	Thu,  3 Jul 2025 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751533366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8oIbtgbzjufoD1KpO0jKiQd5rmqtkhXSUENH8Fb32M=;
	b=eHHl+LfM9NhgLqTeZ/DXbRyNoJ9dpfNFgkD42Ot8ZeKp9I/pM5mDmysIQq+D0a5GC3GO0L
	zRTD/+h3Fqr2EdKES2m2YzSZ64KmMFIVdki60JfQL0hVkIkhkjpm4eabdbDMiesK859l5P
	EUinvj3WVH10LKXUb/A5JmfflkFQ3vGK3R4q6eyQLY9dmb92fRcUI8sT9zY98iz4cg+/3m
	rXHk9PYT+uw4gSmDUMa+QqAaLaliaZL7Ds+Cy+FR7oNmbwRWhDRpSA+r3DYioJ0WrxptW/
	zUGUT0w0s1/CleO3QtA7EsAmLtUv6KZ+msr52XiTlxhBk1t0OhswdRqX8ngLGQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 03 Jul 2025 11:02:32 +0200
Subject: [PATCH v2 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com>
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
In-Reply-To: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsthesf
 hgsrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Most ABIs allow functions to receive structs passed by value, if they
fit in a register or a pair of registers, depending on the exact ABI.
However, when there is a struct passed by value but all registers are
already used for parameters passing, the struct is still passed by value
but on the stack. This becomes an issue if the passed struct is defined
with some attributes like __attribute__((packed)) or
__attribute__((aligned(X)), as its location on the stack is altered, but
this change is not reflected in dwarf information. The corresponding BTF
data generated from this can lead to incorrect BPF trampolines
generation (eg to attach bpf tracing programs to kernel functions) in
the Linux kernel.

Prevent those wrong cases by not encoding functions consuming structs
passed by value on stack, when those structs do not have the expected
alignment due to some attribute usage.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- do not deny any struct passed by value, only those passed on stack AND
  with some attribute alteration
- use the existing class__infer_packed_attributes to deduce is a struct
  is "altered". As a consequence, move the function filtering from
  parameter__new to btf_encoder__encode_cu, to make sure that all the
  needed data has been parsed from debug info
---
 btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 dwarves.h     |  1 +
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc23349b5d740c3ddab8208b2e15cdbdd139b9d..16739066caae808aea77175e6c221afbe37b7c70 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -87,6 +87,7 @@ struct btf_encoder_func_state {
 	uint8_t optimized_parms:1;
 	uint8_t unexpected_reg:1;
 	uint8_t inconsistent_proto:1;
+	uint8_t uncertain_parm_loc:1;
 	int ret_type_id;
 	struct btf_encoder_func_parm *parms;
 	struct btf_encoder_func_annot *annots;
@@ -1203,6 +1204,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->inconsistent_proto = ftype->inconsistent_proto;
 	state->unexpected_reg = ftype->unexpected_reg;
 	state->optimized_parms = ftype->optimized_parms;
+	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
 	ftype__for_each_parameter(ftype, param) {
 		const char *name = parameter__name(param) ?: "";
 
@@ -1430,9 +1432,15 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		/* do not exclude functions with optimized-out parameters; they
 		 * may still be _called_ with the right parameter values, they
 		 * just do not _use_ them.  Only exclude functions with
-		 * unexpected register use or multiple inconsistent prototypes.
+		 * unexpected register use, multiple inconsistent prototypes or
+		 * uncertain parameters location
 		 */
-		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
+		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc;
+
+		if (state->uncertain_parm_loc)
+			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
+					"uncertain parameter location\n",
+					0, 0);
 
 		if (add_to_btf) {
 			err = btf_encoder__add_func(state->encoder, state);
@@ -2553,6 +2561,39 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	free(encoder);
 }
 
+static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ftype)
+{
+	struct parameter *param;
+	int param_idx = 0;
+
+	if (ftype->nr_parms < cu->nr_register_params)
+		return false;
+
+	ftype__for_each_parameter(ftype, param) {
+		if (param_idx++ < cu->nr_register_params)
+			continue;
+
+		struct tag *type = cu__type(cu, param->tag.type);
+
+		if (type == NULL || !tag__is_struct(type))
+			continue;
+
+		struct type *ctype = tag__type(type);
+		if (ctype->namespace.name == 0)
+			continue;
+
+		struct class *class = tag__class(type);
+
+		class__find_holes(class);
+		class__infer_packed_attributes(class, cu);
+
+		if (class->is_packed)
+			return true;
+	}
+
+	return false;
+}
+
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
 {
 	struct llvm_annotation *annot;
@@ -2647,6 +2688,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		 * Skip functions that:
 		 *   - are marked as declarations
 		 *   - do not have full argument names
+		 *   - have arguments with uncertain locations, e.g packed
+		 *   structs passed by value on stack
 		 *   - are not in ftrace list (if it's available)
 		 *   - are not external (in case ftrace filter is not available)
 		 */
@@ -2693,6 +2736,9 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		if (!func)
 			continue;
 
+		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
+			fn->proto.uncertain_parm_loc = 1;
+
 		err = btf_encoder__save_func(encoder, fn, func);
 		if (err)
 			goto out;
diff --git a/dwarves.h b/dwarves.h
index 36c689847ebf29a1ab9936f9d0f928dd46514547..d689aee5910f4b40dc13b3e9dc596dfbe6a2c3d0 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1021,6 +1021,7 @@ struct ftype {
 	uint8_t		 unexpected_reg:1;
 	uint8_t		 processed:1;
 	uint8_t		 inconsistent_proto:1;
+	uint8_t		 uncertain_parm_loc:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
 	struct template_parameter_pack *template_parameter_pack;

-- 
2.50.0



Return-Path: <bpf+bounces-60947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B126ADF098
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D131887815
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29162DBF4C;
	Wed, 18 Jun 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G53KCZa6"
X-Original-To: bpf@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A222EBB8D;
	Wed, 18 Jun 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258953; cv=none; b=V/e1y6jD7E0hrSSMhOiU1pjgGD2X5fU/Di2Sd2LaBIRz5+PwtBc+jwhr5LLTrWuUR0JVFywWU+QvygZyZVTRd9Z4iGsOsLlePUOVB80NDHqzTl/NBlbIh6bj4+0r8+xjOW7AZ8tgT86HAIhEl416NTZS2l/gd4r0n1/Olw+pfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258953; c=relaxed/simple;
	bh=0BUJKvxEgclFebZLkXs2Yiq8R2dLpB16Uc67L6C40P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rxvASWBJGYqZYmwdWW+E/EDO3j5bljbdVCfAAWRSmq0Cg3+ithDqzIaoputE9O+5NOfqTmATF9WGB8SUJc+b/fVbh/TrNJ7NNGaANEDcKbKp3OWzdHDn7pnECVHJrpLiJATseJBwhm5/Mxlor/FUTLNUBY/eaR6zhQaHRg1N+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G53KCZa6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D460243949;
	Wed, 18 Jun 2025 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750258943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yXp3EMZM2KuaBt/hR8mEzxtDjmvXDda0FZvwBvzXw1w=;
	b=G53KCZa6Pfzm90xnM1znRnvLgWJdeHXqf7JBgjSpdCpGbgpsAwyR1rK3LhKbmfhYmjdK67
	bJcK/+UlB+/w3MQeZUnoRt11Mq/57TerE2xQ1yNC87i4tqm67Cf8gSZOjHlRDVCzuOZ6Qu
	A3g5LS7a8lFYrFEDG5a7zcfvRlqTFSwbJxTdliNeoyTiedSmeF+xH6NWA6jctc4nrXtbNy
	NRnBXeWqi9hvJiQ6lYYUCIHKG1ajmTAjb2X3VMxo2dcuiOJrfNqfAeRoVDW6WaciMsi6+j
	evAOQkt+05jU9Lgrwu6mC++f22EHA7UVy0FnkNwhpeczRU9cMdvxL+jsqU3DQw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 18 Jun 2025 17:02:14 +0200
Subject: [PATCH RFC] btf_encoder: skip functions consuming structs passed
 by value on stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPXUUmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nz3aSStPji7MyC+OKSotLkkuL4/DwgMzE5W9fAwCwxJc3E1DzF1EA
 JqL+gKDUtswJsdrRSkJuzUmxtLQCSIdtJcAAAAA==
X-Change-ID: 20250617-btf_skip_structs_on_stack-006adf457d50
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedukeevfedtieefvdefgfdvgfejudeiveduledtueelhfehgfeivdfhtefhgfffgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegso
 hhothhlihhnrdgtohhmpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Most ABIs allow functions to receive structs passed by value, if they
fit in a register or a pair of registers, depending on the exact ABI.
However, when there is a struct passed by value but all registers are
already used for parameters passing, the struct is still passed by value
but on the stack, leading to possible mistakes about its exact location:
if the struct definition has some attributes like
__attribute__((packed)) or __attribute__((aligned(X)), its location on
the stack is altered, but this change is not reflected in dwarf
information. The corresponding BTF data generated from this can lead to
incorrect BPF trampolines generation (eg to attach bpf tracing programs
to kernel functions) in the Linux kernel.

It may not desirable to try to encode this kind of detail in BTF:
- BTF aims to remain a compact format
- this case currently does not really exist in the Linux kernel
- those attributes are not reliably encoded by compilers in DWARF info

So rather than trying to encode more details about those specific
functions, detect those and prevent the encoder from encoding the
corresponding info in BTF

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Hello,
this small RFC series is a follow-up to an attempt to prevent some
possible wrong bpf attachment cases in the kernel.
When attaching ebpf tracing programs to kernel functions, the kernel has
to generate a trampoline able to read and save the target function
arguments. There is a specific case in which we can not reliably perform
this task: most supported architectures allow passing a struct by value
if they fit in a register or a pair of register. The issue is when there
is no available register to pass such argument (eg because all registers
have been used by previous arguments): in this case the struct is passed
by value on the stack, but the exact struct location can not be reliably
deduced by the trampoline, as it may be altered by some attributes like
__attribute__((packed)) or __attribute__((aligned(X)). This detail is
not present in the BTF info used to build the trampoline.

There has been multiple attempts and discussions to handle this case.
[1] is a first attempt, trying to properly support this case, by
deducing more info about the struct passed on stack, but the comments
quickly highlighted some issues. A second attempt ([2]) handled it the
other way around, by simply preventing the trampoline creation if such
variable is consumed by the target function. However, discussions around
this series showed that despite being handled for the specific
architecture receiving this series (ARM64), other architectures still
allow to generate wrong trampolines, as they did not have the
corresponding check. So it has been followed by [3], aiming to enforce
the same constraint for all affected architectures. Alexei eventually
suggested that it may not be the correct direction, and that a solution
could be to just make sure that those specific functions are not
described in BTF info. This series then brings a RFC implementing this
option in pahole. 

This has been tested on both a vmlinux file and bpf_testmod.ko on x86
- in bpf_testmod.ko: bpf_testmod_test_struct_arg_9 is not encoded
  anymore, as it passes a struct bpf_testmod_struct_arg_5 on the stack
- on kernel side:
  - __vxlan_fdb_delete is now encoded in BTF info (I am not sure why
    yet, and I still fail to understand how it relates to this series)
  - vma_modify_flags_uffd is not encoded anymore, as it passes a
    struct vm_userfaultfd_ctx on the stack

A few points remain to be handled/answered, depending on the feedback on
this approach:
- the series currently bring no new test to ensure that those specific
  functions are not encoded
- AFAIU Arnaldo's update on pahole @ LSFMM suggests that  pahole will
  eventually be replaced by compilers as the _main_ tool to  generate
  BTF ([4]), so if the fix is relevant in pahole, it may become relevant
  as well in compilers generating btf data ?
- should this change be locked behind a pahole commandline parameter ?
- sort this __vxlan_fdb_delete issue out

[1] https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com/
[2] https://lore.kernel.org/bpf/20250527-many_args_arm64-v3-0-3faf7bb8e4a2@bootlin.com/
[3] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com/
[4] http://oldvger.kernel.org/~acme/prez/lsfmm-bpf-2025/#/32
---
 btf_encoder.c  | 14 ++++++++++----
 dwarf_loader.c | 17 ++++++++++++++++-
 dwarves.h      |  2 ++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc23349b5d740c3ddab8208b2e15cdbdd139b9d..fc2f114695e9aad790ec4074f37cf6ca51adfeec 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -87,6 +87,7 @@ struct btf_encoder_func_state {
 	uint8_t optimized_parms:1;
 	uint8_t unexpected_reg:1;
 	uint8_t inconsistent_proto:1;
+	uint8_t uncertain_loc:1;
 	int ret_type_id;
 	struct btf_encoder_func_parm *parms;
 	struct btf_encoder_func_annot *annots;
@@ -1203,6 +1204,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->inconsistent_proto = ftype->inconsistent_proto;
 	state->unexpected_reg = ftype->unexpected_reg;
 	state->optimized_parms = ftype->optimized_parms;
+	state->uncertain_loc = ftype->uncertain_loc;
 	ftype__for_each_parameter(ftype, param) {
 		const char *name = parameter__name(param) ?: "";
 
@@ -1365,7 +1367,7 @@ static int saved_functions_cmp(const void *_a, const void *_b)
 
 static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
 {
-	uint8_t optimized, unexpected, inconsistent;
+	uint8_t optimized, unexpected, inconsistent, uncertain_loc;
 	int ret;
 
 	ret = strncmp(a->elf->name, b->elf->name,
@@ -1375,11 +1377,13 @@ static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_
 	optimized = a->optimized_parms | b->optimized_parms;
 	unexpected = a->unexpected_reg | b->unexpected_reg;
 	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
-	if (!unexpected && !inconsistent && !funcs__match(a, b))
+	uncertain_loc = a->uncertain_loc | b->uncertain_loc;
+	if (!unexpected && !inconsistent && !uncertain_loc && !funcs__match(a, b))
 		inconsistent = 1;
 	a->optimized_parms = b->optimized_parms = optimized;
 	a->unexpected_reg = b->unexpected_reg = unexpected;
 	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
+	a->uncertain_loc = b->uncertain_loc = uncertain_loc;
 
 	return 0;
 }
@@ -1432,9 +1436,11 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 * just do not _use_ them.  Only exclude functions with
 		 * unexpected register use or multiple inconsistent prototypes.
 		 */
-		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
+                add_to_btf |= !state->unexpected_reg &&
+                              !state->inconsistent_proto &&
+                              !state->uncertain_loc;
 
-		if (add_to_btf) {
+                if (add_to_btf) {
 			err = btf_encoder__add_func(state->encoder, state);
 			if (err < 0)
 				goto out;
diff --git a/dwarf_loader.c b/dwarf_loader.c
index abf17175d830caa63834464f959e6376223eb19c..ef00cdf308166732fc0938f2eecd56d314d3354f 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1258,8 +1258,20 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
 
-		if (param_idx >= cu->nr_register_params || param_idx < 0)
+		if(param_idx < 0)
 			return parm;
+
+		if (param_idx >= cu->nr_register_params) {
+			if(dwarf_attr(die, DW_AT_type, &attr)){
+				Dwarf_Die type_die;
+				if (dwarf_formref_die(&attr, &type_die) &&
+						dwarf_tag(&type_die) == DW_TAG_structure_type) {
+					parm->uncertain_loc = 1;
+				}
+			}
+			return parm;
+		}
+
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
 		 * are the result of later DWARF generation during compilation
@@ -2953,6 +2965,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 
 			if (pos->unexpected_reg)
 				has_unexpected_reg = true;
+
+			if (pos->uncertain_loc)
+				fn->proto.uncertain_loc = 1;
 		}
 		if (has_unexpected_reg) {
 			ftype__for_each_parameter(&fn->proto, pos) {
diff --git a/dwarves.h b/dwarves.h
index 36c689847ebf29a1ab9936f9d0f928dd46514547..883852f4b60a36d73bce4568cbacd8ef3cff97ea 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -943,6 +943,7 @@ struct parameter {
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
+	uint8_t uncertain_loc:1;
 };
 
 static inline struct parameter *tag__parameter(const struct tag *tag)
@@ -1021,6 +1022,7 @@ struct ftype {
 	uint8_t		 unexpected_reg:1;
 	uint8_t		 processed:1;
 	uint8_t		 inconsistent_proto:1;
+	uint8_t		 uncertain_loc:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
 	struct template_parameter_pack *template_parameter_pack;

---
base-commit: 40c2a7b9277c774a47b27f48ede7d1824587da50
change-id: 20250617-btf_skip_structs_on_stack-006adf457d50

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



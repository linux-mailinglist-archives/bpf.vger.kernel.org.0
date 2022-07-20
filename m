Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3CF57BD5B
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiGTSFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiGTSFC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 14:05:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D165FAC2
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:05:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o21-20020a17090a9f9500b001f0574225faso1547319pjp.6
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p6/8mKcWNBl5IObH8PgGheB6Tot/ibET+8kFX/SOl9s=;
        b=Qxrx5yLM0CzDzJD9eGqFgCi6vAJN59vIY9A8txsVb4T9t/c5YAp9IyAUQeCelkpfFS
         IbvlP/U4WdF569l6/RwGQOZON6hgmDx+Xcn3ERX5OgiXRASnOvMLldDjFnR31YkdE4a4
         O8CAsk+q5CiyI/9mw5Il46Wf6T/wX/waoiaW0ujHZRPotDhpv8yUt6AK2O2jflQGnPLO
         ck+pw9p94YyDQBJYEVYy5x5kLZOfcQ5W41YvSa5wpwmeJfpuhDVzBT1iKehgFoANoLv0
         HgDGYBcybOn85+VToHy+dL4qzITCmyuMl2O2DXNGVn043ztkUaO9Um5fmDsKf40Oqyop
         twng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p6/8mKcWNBl5IObH8PgGheB6Tot/ibET+8kFX/SOl9s=;
        b=Z8bY0XMNm+dk+cHjirWpcVlm/e+v6yP9CN6BYN9dCXjHLi+UXnpw4AFmPJKRx+tsjg
         73eaNcDoesBORyb05xCgx+SsuI/IAVMCCCmfRI6sV/GM9Eo2pm7aVubw3g1zJl0W2DTo
         jG8fM59I+uCwbVY7+HbOZ3pB5GKtkhboe3ZjYx0XRzaBYCu/my1LwfQdHZOsqFwSOgz9
         39zTDsbzFChksAX6L+oQeJY0veD9NFlmEqhMFIquRVVcnb5l67nD7QZvXDfyQhQdroMj
         zsAwa64xs89RfcjVPsESJSyWcXklFj89wjh8RQsZreIUB44oPx+MMrxv4jKwBzw986OD
         ryiA==
X-Gm-Message-State: AJIora8m7AfMzChaj5MRCfeSIWiotBXzp9ag77JGDYB5Oyt6yAvTd+Ii
        0qQ42b0wMS5kjEntDGzJWIsuT9s=
X-Google-Smtp-Source: AGRyM1ujKdk44d19ChSUNc0tiRjXeP0Nc/ijPPfLzBkYLRLaYW7NL1mGQxJ6ZxC4DBZGLUlguTmtDCw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP id
 p14-20020a17090b010e00b001f1f3b09304mr517102pjz.1.1658340300514; Wed, 20 Jul
 2022 11:05:00 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:04:59 -0700
In-Reply-To: <Ytc8RvDTpEmC0pQD@google.com>
Message-Id: <YthDy8uhE2ky0rBr@google.com>
Mime-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
 <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
 <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com> <Ytc8RvDTpEmC0pQD@google.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/19, sdf@google.com wrote:
> On 07/19, Alexei Starovoitov wrote:
> > On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com>  
> wrote:
> > >
> > > On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com>
> > wrote:
> > > >
> > > > On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev
> > <sdf@google.com> wrote:
> > > > > >
> > > > > > Motivation:
> > > > > >
> > > > > > Our bpf programs have a bunch of options which are set at the
> > loading
> > > > > > time. After loading, they don't change. We currently use array  
> map
> > > > > > to store them and bpf program does the following:
> > > > > >
> > > > > > val = bpf_map_lookup_elem(&config_map, &key);
> > > > > > if (likely(val && *val)) {
> > > > > >   // do some optional feature
> > > > > > }
> > > > > >
> > > > > > Since the configuration is static and we have a lot of those
> > features,
> > > > > > I feel like we're wasting precious cycles doing dynamic lookups
> > > > > > (and stalling on memory loads).
> > > > > >
> > > > > > I was assuming that converting those to some fake kconfig  
> options
> > > > > > would solve it, but it still seems like kconfig is stored in the
> > > > > > global map and kconfig entries are resolved dynamically.
> > > > > >
> > > > > > Proposal:
> > > > > >
> > > > > > Resolve kconfig options statically upon loading. Basically  
> rewrite
> > > > > > ld+ldx to two nops and 'mov val, x'.
> > > > > >
> > > > > > I'm also trying to rewrite conditional jump when the condition  
> is
> > > > > > !imm. This seems to be catching all the cases in my program, but
> > > > > > it's probably too hacky.
> > > > > >
> > > > > > I've attached very raw RFC patch to demonstrate the idea.  
> Anything
> > > > > > I'm missing? Any potential problems with this approach?
> > > > >
> > > > > Have you considered using global variables for that?
> > > > > With skeleton the user space has a natural way to set
> > > > > all of these knobs after doing skel_open and before skel_load.
> > > > > Then the verifier sees them as readonly vars and
> > > > > automatically converts LDX into fixed constants and if the code
> > > > > looks like if (my_config_var) then the verifier will remove
> > > > > all the dead code too.
> > > >
> > > > Hm, that's a good alternative, let me try it out. Thanks!
> > >
> > > Turns out we already freeze kconfig map in libbpf:
> > > if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
> > >         err = bpf_map_freeze(map->fd);
> > >
> > > And I've verified that I do hit bpf_map_direct_read in the verifier.
> > >
> > > But the code still stays the same (bpftool dump xlated):
> > >   72: (18) r1 = map[id:24][0]+20
> > >   74: (61) r1 = *(u32 *)(r1 +0)
> > >   75: (bf) r2 = r9
> > >   76: (b7) r0 = 0
> > >   77: (15) if r1 == 0x0 goto pc+9
> > >
> > > I guess there is nothing for sanitize_dead_code to do because my
> > > conditional is "if (likely(some_condition)) { do something }" and the
> > > branch instruction itself is '.seen' by the verifier.

> > I bet your variable is not 'const'.
> > Please see any of the progs in selftests that do:
> > const volatile int var = 123;
> > to express configs.

> Yeah, I was testing against the following:

> 	extern int CONFIG_XYZ __kconfig __weak;

> But ended up writing this small reproducer:

> 	struct __sk_buff;

> 	const volatile int CONFIG_DROP = 1; // volatile so it's not
> 					    // clang-optimized

> 	__attribute__((section("tc"), used))
> 	int my_config(struct __sk_buff *skb)
> 	{
> 		int ret = 0; /*TC_ACT_OK*/

> 		if (CONFIG_DROP)
> 			ret = 2 /*TC_ACT_SHOT*/;

> 		return ret;
> 	}

> $ bpftool map dump name my_confi.rodata

> [{
>          "value": {
>              ".rodata": [{
>                      "CONFIG_DROP": 1
>                  }
>              ]
>          }
>      }
> ]

> $ bpftool prog dump xlated name my_config

> int my_config(struct __sk_buff * skb):
> ; if (CONFIG_DROP)
>     0: (18) r1 = map[id:3][0]+0
>     2: (61) r1 = *(u32 *)(r1 +0)
>     3: (b4) w0 = 1
> ; if (CONFIG_DROP)
>     4: (64) w0 <<= 1
> ; return ret;
>     5: (95) exit

> The branch is gone, but the map lookup is still there :-(

Attached another RFC below which is doing the same but from the verifier
side. It seems we should be able to resolve LD+LDX if their dst_reg
is the same? If they are different, we should be able to pre-lookup
LDX value at least. Would something like this work (haven't run full
verifier/test_progs yet)?

(note, in this case, with kconfig, I still see the branch)

  test_fold_ro_ldx:PASS:open 0 nsec
  test_fold_ro_ldx:PASS:load 0 nsec
  test_fold_ro_ldx:PASS:bpf_obj_get_info_by_fd 0 nsec
  int fold_ro_ldx(struct __sk_buff * skb):
  ; if (CONFIG_DROP)
     0: (b7) r1 = 1
     1: (b4) w0 = 1
  ; if (CONFIG_DROP)
     2: (16) if w1 == 0x0 goto pc+1
     3: (b4) w0 = 2
  ; return ret;
     4: (95) exit
  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
  #66      fold_ro_ldx:OK

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
  kernel/bpf/verifier.c                         | 74 ++++++++++++++++++-
  .../selftests/bpf/prog_tests/fold_ro_ldx.c    | 52 +++++++++++++
  .../testing/selftests/bpf/progs/fold_ro_ldx.c | 20 +++++
  3 files changed, 144 insertions(+), 2 deletions(-)
  create mode 100644 tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
  create mode 100644 tools/testing/selftests/bpf/progs/fold_ro_ldx.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c59c3df0fea6..ffedd8234288 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12695,6 +12695,69 @@ static bool bpf_map_is_cgroup_storage(struct  
bpf_map *map)
  		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
  }

+/* if the map is read-only, we can try to fully resolve the load */
+static bool fold_ro_pseudo_ldimm64(struct bpf_verifier_env *env,
+				   struct bpf_map *map,
+				   struct bpf_insn *insn)
+{
+	struct bpf_insn *ldx_insn = insn + 2;
+	int dst_reg = ldx_insn->dst_reg;
+	u64 val = 0;
+	int size;
+	int err;
+
+	if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr)
+		return false;
+
+	/* 0: BPF_LD  r=MAP
+	 * 1: BPF_LD  r=MAP
+	 * 2: BPF_LDX r=MAP->VAL
+	 */
+
+	if (BPF_CLASS((insn+0)->code) != BPF_LD ||
+	    BPF_CLASS((insn+1)->code) != BPF_LD ||
+	    BPF_CLASS((insn+2)->code) != BPF_LDX)
+		return false;
+
+	if (BPF_MODE((insn+0)->code) != BPF_IMM ||
+	    BPF_MODE((insn+1)->code) != BPF_IMM ||
+	    BPF_MODE((insn+2)->code) != BPF_MEM)
+		return false;
+
+	if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
+	    insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE)
+		return false;
+
+	if (insn->dst_reg != ldx_insn->src_reg)
+		return false;
+
+	if (ldx_insn->off != 0)
+		return false;
+
+	size = bpf_size_to_bytes(BPF_SIZE(ldx_insn->code));
+	if (size < 0 || size > 4)
+		return false;
+
+	err = bpf_map_direct_read(map, (insn+1)->imm, size, &val);
+	if (err)
+		return false;
+
+	if (insn->dst_reg == ldx_insn->dst_reg) {
+		/* LDX is using the same destination register as LD.
+		 * This means we are not interested in the map
+		 * pointer itself and can remove it.
+		 */
+		*(insn + 0) = BPF_JMP_A(0);
+		*(insn + 1) = BPF_JMP_A(0);
+		*(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
+		return true;
+	}
+
+	*(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
+	/* Only LDX can be resolved, we still have to resolve LD address. */
+	return false;
+}
+
  /* find and rewrite pseudo imm in ld_imm64 instructions:
   *
   * 1. if it accesses map FD, replace it with actual map pointer.
@@ -12713,6 +12776,8 @@ static int resolve_pseudo_ldimm64(struct  
bpf_verifier_env *env)
  		return err;

  	for (i = 0; i < insn_cnt; i++, insn++) {
+		bool folded = false;
+
  		if (BPF_CLASS(insn->code) == BPF_LDX &&
  		    (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0)) {
  			verbose(env, "BPF_LDX uses reserved fields\n");
@@ -12830,8 +12895,13 @@ static int resolve_pseudo_ldimm64(struct  
bpf_verifier_env *env)
  				addr += off;
  			}

-			insn[0].imm = (u32)addr;
-			insn[1].imm = addr >> 32;
+			if (i + 2 < insn_cnt)
+				folded = fold_ro_pseudo_ldimm64(env, map, insn);
+
+			if (!folded) {
+				insn[0].imm = (u32)addr;
+				insn[1].imm = addr >> 32;
+			}

  			/* check whether we recorded this map already */
  			for (j = 0; j < env->used_map_cnt; j++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c  
b/tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
new file mode 100644
index 000000000000..faaf8423ebca
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "fold_ro_ldx.skel.h"
+
+void test_fold_ro_ldx(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, skel_opts,
+		.kconfig = "CONFIG_DROP=1",
+	);
+	struct fold_ro_ldx *skel = NULL;
+	struct bpf_prog_info info = {};
+	struct bpf_insn insn[16];
+	__u32 info_len;
+	FILE *bpftool;
+	char buf[256];
+	int err;
+	int i;
+
+	skel = fold_ro_ldx__open_opts(&skel_opts);
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto close_skel;
+
+	if (!ASSERT_OK(fold_ro_ldx__load(skel), "load"))
+		goto close_skel;
+
+	info.xlated_prog_len = sizeof(insn);
+	info.xlated_prog_insns = ptr_to_u64(insn);
+
+	info_len = sizeof(struct bpf_prog_info);
+	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.fold_ro_ldx),
+				     &info, &info_len);
+	if (!ASSERT_GE(err, 0, "bpf_obj_get_info_by_fd"))
+		goto close_skel;
+
+	// Put xlated output into stdout in case verification below fails.
+	bpftool = popen("bpftool prog dump xlated name fold_ro_ldx", "r");
+	while (fread(buf, 1, sizeof(buf), bpftool) > 0)
+		fwrite(buf, 1, strlen(buf), stdout);
+	pclose(bpftool);
+
+	for (i = 0; i < info.xlated_prog_len / sizeof(struct bpf_insn); i++) {
+		ASSERT_NEQ(BPF_CLASS(insn[i].code), BPF_LD, "found BPF_LD");
+		ASSERT_NEQ(BPF_CLASS(insn[i].code), BPF_LDX, "found BPF_LDX");
+	}
+
+close_skel:
+	fold_ro_ldx__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fold_ro_ldx.c  
b/tools/testing/selftests/bpf/progs/fold_ro_ldx.c
new file mode 100644
index 000000000000..c83ac65e2dee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fold_ro_ldx.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern const int CONFIG_DROP __kconfig __weak;
+
+struct __sk_buff;
+
+SEC("tc")
+int fold_ro_ldx(struct __sk_buff *skb)
+{
+	int ret = 1;
+
+	if (CONFIG_DROP)
+		ret = 2;
+
+	return ret;
+}
-- 
2.37.0.170.g444d1eabd0-goog



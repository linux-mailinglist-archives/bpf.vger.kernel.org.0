Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD0557D75
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiFWOCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiFWOCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 10:02:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E173D1FC
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 07:02:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so21341716edb.6
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=5r3iGqALvckFVuR6nYT+Mio0vEfbpHsiFY4kZUXuWaQ=;
        b=DfuQiNi8u1SrgS7ZvESwWhT8rq6dZyyf1ARRlb0EGX4Uhu4i/ysHhYcpsdh8A5m3ET
         FNzBaKqVDmuSTZYybRyU0Pkq5NBMmObWwvUqmU/G9sO8Es+80jSpnr+vbozrW2jRdppr
         z/q8isvUo/oR3LRw62LHv7Mhrhzl2KQDnQewqlTNy4ty0vzdulVrUXJ8nSmaV5HyuK8A
         MqFWNcMQ8JOh6egutIcr2OsTllBYexY/gZk1d8F26jyg3pmd550e9CKBgFyx3YoAbofI
         JtpPvRe1uJhnNBPL2OtzIG8lE72/KEVrkSMdCmOc2d19vWDF0UmUgyEI8Hnk5QUnK9hG
         ooXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=5r3iGqALvckFVuR6nYT+Mio0vEfbpHsiFY4kZUXuWaQ=;
        b=t/ax1aBt3TIUAXx3smfclk52dJ3tDyRs64mt6+P4ydtGzhEhwo1wN0RS68fQysYQvu
         +S1xIePARUeXGDKbqs8MZdr5yAe4uFV2RswDPIVeYtgH+tMtRGC8UPGdWuLMwU2zlEXI
         8YuDBwkmv1tjCB2ewLS+ZM0LEO1q+hO1iy2TleW+Y0M/ponrWzPWT1M0+fBY1tfXOxIP
         Iuw40LU4reE133TI0FxCS0gAwRHgfykRrMue0b7vtDpQE9OdT0Gg9EkyRGMUGzJgBpy/
         dox8X8VK3RAlCloqdA97ONd7AgTFN9MLS87SvB1Cq+0KfUU8FD+Y1EyneeDxhJHIREPV
         1Prg==
X-Gm-Message-State: AJIora8cVeYyE3t0rXnlKV8OzHXLWueaxuxj24c43JpUIyENcFB4Tirs
        ZSWfI50sQaUZVrgD9L2jnadNCrRZq2e4WQ==
X-Google-Smtp-Source: AGRyM1s/Orh+Go3j15ZlsQ2291+klMu/LrheN6qOfrvJbqei8uojQNhEyRT+Vo9wjnxBbuZv8JPzuw==
X-Received: by 2002:a05:6402:2999:b0:434:edcc:f12c with SMTP id eq25-20020a056402299900b00434edccf12cmr10755373edb.96.1655992956967;
        Thu, 23 Jun 2022 07:02:36 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e1-20020a056402148100b004357171dcccsm12703694edv.12.2022.06.23.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 07:02:36 -0700 (PDT)
Message-ID: <5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.camel@gmail.com>
Subject: Re: [RFC bpf-next] Speedup for verifier.c:do_misc_fixups
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Date:   Thu, 23 Jun 2022 17:02:34 +0300
In-Reply-To: <20220623031101.q7kwa5jb4e7czqso@macbook-pro-3.dhcp.thefacebook.com>
References: <43f4de24e5981152b8a31d4629e199c012c4f52c.camel@gmail.com>
         <20220623031101.q7kwa5jb4e7czqso@macbook-pro-3.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Wed, 2022-06-22 at 20:11 -0700, Alexei Starovoitov wrote:
[...]
> tbh sounds scary. We had so many bugs in the patch_insn over years.
> The code is subtle.

In terms of testing strategy the following could be done:
- use pseudo-random testing to verify that `bpf_patch_insn_data` and
  the mechanism suggested in my email produce identical code.
- use pseudo-random testing to verify that offsets after rewrite point
  to expected instructions (e.g. use .imm field as a unique marker for
  the instruction).
- hand-written tests for corner cases.

Would you consider this to be sufficient?  (Probably does not sound
too reassuring from the person[me] who submits patches with trivial
use after free errors :)

[...]

> Before proceeding too far based on artificial test please collect
> the number of patches and their sizes we currently do across all progs
> in selftests. Maybe it's not that bad in real code.

I will collect and share the stats on Saturday or Sunday.

> As far as algo the patch_and_copy_insn() assumes that 'dst' insn is a bra=
nch?
> I guess I'm missing some parts of the proposed algo.

Sorry, I made a mistake in the original email, the code for
patch_and_copy_insn() should look as follows:

static void patch_and_copy_insn(struct bpf_patching_state *state, int pc,
				struct bpf_insn *dst, struct bpf_insn *src) {
	memcpy(dst, src, sizeof(struct bpf_insn));
	// TODO: other classes
	// TODO: also adjust imm for calls
	if (BPF_CLASS(src->code) =3D=3D BPF_JMP) {
		int new_pc =3D pc + lookup_delta_for_index(state, pc);
		int dst_pc =3D pc + src->off + 1;
		int new_dst =3D dst_pc + lookup_delta_for_index(state, dst_pc);
		dst->off =3D new_dst - new_pc - 1;
	}
}


The logic is as follows:
- compute new instruction index for the old pc
- compute new instruction index for the (old pc + offset)
- use these values to compute the new offset

The draft implementation of this algorithm is at the end of this
email.

> Instead of delaying everything maybe we can do all patching inline
> except bpf_adj_branches?
> Remember only:
>    int offset;             /* index inside the original program,
>                             * the instruction at this index would be repl=
aced.
>                             */
>    int insns_count;        /* size of the patch */
>    int delta;              /* difference in indexes between original prog=
ram and
>                             * new program after application of all patche=
s up to
>                             * and including this one.
>                             */
> and do single bpf_adj_branches at the end ?

The algorithm consists of two parts:
- To avoid excessive copying patches are accumulated in a separate
  array and size of this array is doubled each time the capacity is
  not sufficient to fit a new patch. This should have O(log(n))
  complexity in terms of copied bytes.
- To avoid excessive branch adjustment passes a single branch
  adjustment pass is performed at the end. This pass visits each
  instruction only once, however, for each instruction it will have
  to query the delta value in a sorted array. Thus the overall
  complexity of this pass would be O(n*log(n)). It is possible to
  adjust some relevant fields in `env` during this pass as well.

If the first part is skipped and patching is done inline, then for
each patch:
- `realloc` is invoked (relatively cheap?)
- `memcpy` is invoked to copy the head and tail of the current
  program.  This has O(n**2) worst case complexity in terms of copied
  memory.

Thanks,
Eduard

---

/* Draft implementation of the proposed algorithm, written as user
 * space code, thus calls bzero etc. Should be buggy but I'll figure
 * it out. */
  =20

#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#define BPF_CLASS(code) ((code)&0x07)
#define BPF_JMP 0x05

struct bpf_insn {
	uint8_t code;
	uint8_t dst_reg : 4;
	uint8_t src_reg : 4;
	int16_t off;
	int32_t imm;
};

struct bpf_patch {
	int offset;
	int insns_count;
	int delta;
	struct bpf_insn *insns;
};

struct bpf_patching_state {
	struct bpf_patch *patches;
	int patches_count;
	int patches_capacity;
	struct bpf_insn *insns;
	int insns_count;
	int insns_capacity;
};

static int init_patching_state(struct bpf_patching_state *state) {
	bzero(state, sizeof(*state));
	state->patches_count =3D 0;
	state->patches_capacity =3D 1; // small number, just for testing
	state->patches =3D calloc(state->patches_capacity, sizeof(struct bpf_patch=
));
	if (!state->patches)
		goto err;
	state->insns_count =3D 0;
	state->insns_capacity =3D 2; // small number, just for testing
	state->insns =3D calloc(state->insns_capacity, sizeof(struct bpf_insn));
	if (!state->insns)
		goto err;

	return 0;

err:
	if (state->patches)
		free(state->patches);
	if (state->insns)
		free(state->insns);
	return -ENOMEM;
}

static void free_patching_state(struct bpf_patching_state *state) {
	free(state->patches);
	free(state->insns);
	bzero(state, sizeof(*state));
}

static int add_patch(struct bpf_patching_state *state, int offset,
		     int insns_count, struct bpf_insn *insns)
{
	if (state->patches_count =3D=3D state->patches_capacity) {
		struct bpf_patch *new_patches =3D
			reallocarray(state->patches, state->patches_capacity * 2,
				         sizeof(struct bpf_patch));
		if (!new_patches)
			return -ENOMEM;
		state->patches =3D new_patches;
		state->patches_capacity *=3D 2;
	}

	int insns_available =3D state->insns_capacity - state->insns_count;
	if (insns_available < insns_count) {
		int cur_capacity =3D (state->insns_capacity > insns_count
							? state->insns_capacity
							: insns_count);
		int new_capacity =3D cur_capacity * 2;
		struct bpf_insn *new_insns =3D
			reallocarray(state->insns, new_capacity, sizeof(struct bpf_insn));
		if (!new_insns)
			return -ENOMEM;
		state->insns =3D new_insns;
		state->insns_capacity =3D new_capacity;
	}

	struct bpf_patch *patch =3D &state->patches[state->patches_count];
	struct bpf_insn *dest_insns =3D &state->insns[state->insns_count];
	state->patches_count +=3D 1;
	state->insns_count +=3D insns_count;
	patch->offset =3D offset;
	patch->insns_count =3D insns_count;
	patch->insns =3D insns;
	patch->delta =3D 0;
	memcpy(dest_insns, insns, insns_count * sizeof(struct bpf_insn));

	return 0;
}

static int lookup_delta_for_index(struct bpf_patching_state *state, int ind=
ex)
{
	struct bpf_patch *patches =3D state->patches;

	if (state->patches_count =3D=3D 0 || index < patches[0].offset)
		return 0;

	if (state->patches_count =3D=3D 1)
		return patches[0].delta;

	int l =3D 0;
	int r =3D state->patches_count - 1;

	while (r - l !=3D 1) {
		int m =3D l + (r - l) / 2;
		if (patches[m].offset < index)
			l =3D m;
		else
			r =3D m;
	}

	if (patches[r].offset < index)
		return patches[r].delta;
	else
		return patches[l].delta;
}

static void patch_and_copy_insn(struct bpf_patching_state *state, int pc,
				struct bpf_insn *dst, struct bpf_insn *src) {
	memcpy(dst, src, sizeof(struct bpf_insn));
	// TODO: other classes
	// TODO: also adjust imm for calls
	if (BPF_CLASS(src->code) =3D=3D BPF_JMP) {
		int new_pc =3D pc + lookup_delta_for_index(state, pc);
		int dst_pc =3D pc + src->off + 1;
		int new_dst =3D dst_pc + lookup_delta_for_index(state, dst_pc);
		dst->off =3D new_dst - new_pc - 1;
	}
}

static struct bpf_insn *apply_patches(struct bpf_patching_state *state,
				      struct bpf_insn *prog, int *prog_size)
{
	int delta =3D 0;
	for (int i =3D 0; i < state->patches_count; ++i) {
		delta +=3D state->patches[i].insns_count - 1;
		state->patches[i].delta =3D delta;
	}
	int old_prog_size =3D *prog_size;
	int new_prog_size =3D old_prog_size + delta;
	struct bpf_insn *new_prog =3D calloc(new_prog_size, sizeof(struct bpf_insn=
));
	if (!new_prog)
		return NULL;

	*prog_size =3D new_prog_size;

	struct bpf_insn *old_insn =3D prog;
	struct bpf_insn *new_insn =3D new_prog;
	int next_patch =3D 0;
	for (int i =3D 0; i < old_prog_size; ++i) {
		// TODO: deal with double-word immediate values correctly
		if (next_patch < state->patches_count &&
		    state->patches[next_patch].offset =3D=3D i) {
			struct bpf_patch *patch =3D &state->patches[next_patch];
			for (int j =3D 0; j < patch->insns_count; ++j) {
				patch_and_copy_insn(state, i + j,
									new_insn, &patch->insns[j]);
				++new_insn;
			}
			++next_patch;
		} else {
			patch_and_copy_insn(state, i, new_insn, old_insn);
			++new_insn;
		}
		++old_insn;
	}

	return new_prog;
}

static void show_prog(struct bpf_insn *prog, int cnt) {
	for (int i =3D 0; i < cnt; ++i) {
		printf("%02d: .code =3D %02d, .off =3D %+03d, .imm =3D %+03d", i, prog[i]=
.code,
		       prog[i].off, prog[i].imm);
		if (BPF_CLASS(prog[i].code) =3D=3D BPF_JMP) {
			int jmp_idx =3D i + prog[i].off + 1;
			printf(", jmp to %02d .imm =3D %+03d", jmp_idx, prog[jmp_idx].imm);
		}
		printf("\n");
	}
}

int main(int argc, char **argv) {
	struct bpf_insn prog[] =3D {
		{.code =3D 0, .imm =3D 0},
		{.code =3D BPF_JMP, .off =3D 3, .imm =3D 1},
		{.code =3D 0, .imm =3D 2},
		{.code =3D 0, .imm =3D 3},
		{.code =3D BPF_JMP, .off =3D 1, .imm =3D 4},
		{.code =3D 0, .imm =3D 5},
		{.code =3D 0, .imm =3D 6},
		{.code =3D BPF_JMP, .off =3D -5, .imm =3D 7},
		{.code =3D 0, .imm =3D 8},
		{.code =3D BPF_JMP, .off =3D 0, .imm =3D 9},
		{.code =3D 0, .imm =3D 10},
		{.code =3D BPF_JMP, .off =3D -11, .imm =3D 11},
	};
	int cnt =3D sizeof(prog) / sizeof(prog[0]);
	struct bpf_patching_state st;
	init_patching_state(&st);
	struct bpf_insn p1[] =3D {{.imm =3D -10}, {.imm =3D -11}};
	add_patch(&st, 0, 2, p1);
	struct bpf_insn p2[] =3D {
		{.imm =3D -20},
		{.imm =3D -21},
		{.imm =3D -22},
	};
	add_patch(&st, 2, 3, p2);
	struct bpf_insn p3[] =3D {
		{.imm =3D -30},
		{.imm =3D -31},
		{.code =3D BPF_JMP, .off =3D 1, .imm =3D -32}, // jump out of patch by 1 =
insn
		{.imm =3D -33}
	};
	add_patch(&st, 8, 4, p3);
	int new_prog_cnt =3D cnt;
	struct bpf_insn *new_prog =3D apply_patches(&st, prog, &new_prog_cnt);
	free_patching_state(&st);

	printf("Prog before:\n");
	show_prog(prog, cnt);
	printf("\nProg after:\n");
	show_prog(new_prog, new_prog_cnt);
	free(new_prog);

	return 0;
}

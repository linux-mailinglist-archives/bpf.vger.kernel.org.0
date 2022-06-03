Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559EE53D342
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbiFCVbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348976AbiFCVbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:31:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899A5401C
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE91CCE24D3
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 21:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CD6C3411D
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654291888;
        bh=Ld9VEA2fUvzB18ooITpcWhty9tZaUFAuMrtwZvXWhNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ck8ft9JKnaNVinL0ogQs8CGTmQagEQjSDfE1YBLgEgBxPPj73J6hB/r75s7lnH/6E
         wDd1mCs81WmC47Ogdxdt5EkUl2ag8YxyjpXbwtucgt8JArGadSclsVe4Ze4rbGgXRo
         tHLlzXJm/2IKyKIm2C7+bS/eYADVtJz/HN4+/GIgsfHhewOvwjNMfJK0XqnZnfVSwg
         MVTj+AIDtvdEUhZbEEI3t0d9OBLo1cnprJAjitHNbj3MISuubZJUXQiRyYzmPMPXfK
         leRWKyMoZOirVipCJE1+98oLNLX0W1pEmysl0Nu3FhHo7OTiOo+3TXCisd1NCla4R2
         r/unrETQNozdQ==
Received: by mail-yb1-f176.google.com with SMTP id a64so15883151ybg.11
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:31:28 -0700 (PDT)
X-Gm-Message-State: AOAM533Wz2ivPGKboJ+NjOUcPwQuH4Vbv4TN0Ws6bORiEbkk1xemiaAv
        r86kX/NP0NJUjUZvqO4jV0l9wN/pp8hSIbuTZAI=
X-Google-Smtp-Source: ABdhPJx6w1yfOLH3PhbfeYUrzAQj0fBojTTjMCcfOLavuihvA8iGJ0neRRRsViy9F6tlsJEk1yROx1kEJHY2Y8klz2M=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr13012659ybc.257.1654291887794; Fri, 03
 Jun 2022 14:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-2-eddyz87@gmail.com>
In-Reply-To: <20220603141047.2163170-2-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jun 2022 14:31:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5WrL-4qZz-NPufj7SWbWe+z4rVzc0cN3ufU2M_PnTwoQ@mail.gmail.com>
Message-ID: <CAPhsuW5WrL-4qZz-NPufj7SWbWe+z4rVzc0cN3ufU2M_PnTwoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: specify expected
 instructions in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 3, 2022 at 7:11 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
[...]

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 222 ++++++++++++++++++++
>  1 file changed, 222 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 372579c9f45e..373f7661f4d0 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -51,6 +51,8 @@
>  #endif
>
>  #define MAX_INSNS      BPF_MAXINSNS
> +#define MAX_EXPECTED_INSNS     32
> +#define MAX_UNEXPECTED_INSNS   32
>  #define MAX_TEST_INSNS 1000000
>  #define MAX_FIXUPS     8
>  #define MAX_NR_MAPS    23
> @@ -58,6 +60,10 @@
>  #define POINTER_VALUE  0xcafe4all
>  #define TEST_DATA_LEN  64
>
> +#define INSN_OFF_MASK  ((s16)0xFFFF)
> +#define INSN_IMM_MASK  ((s32)0xFFFFFFFF)

Shall we use __s16 and __s32 to match struct bpf_insn exactly.

> +#define SKIP_INSNS()   BPF_RAW_INSN(0xde, 0xa, 0xd, 0xbeef, 0xdeadbeef)
> +
>  #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS     (1 << 0)
>  #define F_LOAD_WITH_STRICT_ALIGNMENT           (1 << 1)
>
> @@ -79,6 +85,19 @@ struct bpf_test {
>         const char *descr;
>         struct bpf_insn insns[MAX_INSNS];
>         struct bpf_insn *fill_insns;
> +       /* If specified, test engine looks for this sequence of
> +        * instructions in the BPF program after loading. Allows to
> +        * test rewrites applied by verifier.  Use values
> +        * INSN_OFF_MASK and INSN_IMM_MASK to mask `off` and `imm`
> +        * fields if content does not matter.  The test case fails if
> +        * specified instructions are not found.
> +        *
> +        * The sequence could be split into sub-sequences by adding
> +        * SKIP_INSNS instruction at the end of each sub-sequence. In
> +        * such case sub-sequences are searched for one after another.
> +        */
> +       struct bpf_insn expected_insns[MAX_EXPECTED_INSNS];
> +       struct bpf_insn unexpected_insns[MAX_UNEXPECTED_INSNS];
>         int fixup_map_hash_8b[MAX_FIXUPS];
>         int fixup_map_hash_48b[MAX_FIXUPS];
>         int fixup_map_hash_16b[MAX_FIXUPS];
> @@ -1126,6 +1145,206 @@ static bool cmp_str_seq(const char *log, const char *exp)
>         return true;
>  }
>
> +static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       __u32 xlated_prog_len;
> +       __u32 buf_elt_size = sizeof(**buf);

I guess elt means "element"? I would recommend use sizeof(struct bpf_insn)
directly.

[...]

> +static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
> +{
> +       for (int i = 0; i < max_len; ++i) {

Sorry for missing this in v1. We should really pull variable
declaration out, like

int i;

for (int i = 0; ...)

> +               if (is_null_insn(&seq[i]))
> +                       return i;
> +       }
> +       return max_len;
> +}
> +
[...]

> +
> +static int find_insn_subseq(struct bpf_insn *seq, struct bpf_insn *subseq,
> +                           int seq_len, int subseq_len)
> +{
> +       if (subseq_len > seq_len)
> +               return -1;
> +
> +       for (int i = 0; i < seq_len - subseq_len + 1; ++i) {
> +               bool found = true;
> +
> +               for (int j = 0; j < subseq_len; ++j) {
> +                       if (!compare_masked_insn(&seq[i + j], &subseq[j])) {
> +                               found = false;
> +                               break;
> +                       }
> +               }
> +               if (found)
> +                       return i;
> +       }
> +
> +       return -1;
> +}
> +

[...]

> +
> +static bool check_xlated_program(struct bpf_test *test, int fd_prog)
> +{
> +       struct bpf_insn *buf;
> +       int cnt;
> +       bool result = true;
> +       bool check_expected = !is_null_insn(test->expected_insns);
> +       bool check_unexpected = !is_null_insn(test->unexpected_insns);
> +
> +       if (!check_expected && !check_unexpected)
> +               goto out;
> +
> +       if (get_xlated_program(fd_prog, &buf, &cnt)) {
> +               printf("FAIL: can't get xlated program\n");
> +               result = false;
> +               goto out;
> +       }
> +
> +       if (check_expected &&
> +           !find_all_insn_subseqs(buf, test->expected_insns,
> +                                  cnt, MAX_EXPECTED_INSNS)) {
> +               printf("FAIL: can't find expected subsequence of instructions\n");
> +               result = false;
> +               if (verbose) {
> +                       printf("Program:\n");
> +                       print_insn(buf, cnt);
> +                       printf("Expected subsequence:\n");
> +                       print_insn(test->expected_insns, MAX_EXPECTED_INSNS);
> +               }
> +       }
> +
> +       if (check_unexpected &&
> +           find_all_insn_subseqs(buf, test->unexpected_insns,
> +                                 cnt, MAX_UNEXPECTED_INSNS)) {

I wonder whether we want different logic for unexpected_insns. With multiple
sub sequences, say seq-A and seq-B, it is more natural to reject any results
with either seq-A or seq-B. However, current logic will reject seq-A => seq-B,
but will accept seq-B => seq-A. Does this make sense?

> +               printf("FAIL: found unexpected subsequence of instructions\n");
> +               result = false;
> +               if (verbose) {
> +                       printf("Program:\n");
> +                       print_insn(buf, cnt);
> +                       printf("Un-expected subsequence:\n");
> +                       print_insn(test->unexpected_insns, MAX_UNEXPECTED_INSNS);
> +               }
> +       }
> +
> +       free(buf);
> + out:
> +       return result;
> +}
> +
>  static void do_test_single(struct bpf_test *test, bool unpriv,
>                            int *passes, int *errors)
>  {
> @@ -1262,6 +1481,9 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>         if (verbose)
>                 printf(", verifier log:\n%s", bpf_vlog);
>
> +       if (!check_xlated_program(test, fd_prog))
> +               goto fail_log;
> +
>         run_errs = 0;
>         run_successes = 0;
>         if (!alignment_prevented_execution && fd_prog >= 0 && test->runs >= 0) {
> --
> 2.25.1
>

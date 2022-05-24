Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA365320D3
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 04:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiEXCPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 22:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiEXCPx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 22:15:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87C9CC8D
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 19:15:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t13so4519828wrg.9
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 19:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpzA5dS2Gmzq34AmsG0piX5swYKqW4XUdFt52HZBDAU=;
        b=P92OVhDRr/UH0wbRxf4gQqrBiy4/a8otmhk5Mz750O95F+8LYCpHQMbuwwgEidzMcI
         M6cPaNMYBZeUTobagfxnLRbkunEa02wI64YQhgQTL8e16BkDcjoNhRVonKi8ziayZhMQ
         Y5fkxM+iMKti1x84+65EHnkl/oE3XiKC3SbJ4caeI3w9J0tZImrKGEhAxcMUXvagojhx
         KvFof+WMGULeyXUiPlW2tTZw+4Fd/k0RWWNF7rWJXBrrn5g88i3jxCO2iSpsEvM9X5eo
         zm2bTSF/9rBKg96WV3AL1EiqPtBB8tFciI7xTnJt9fWLLLdEovOhPpwnV+i8o1pHvGts
         yu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpzA5dS2Gmzq34AmsG0piX5swYKqW4XUdFt52HZBDAU=;
        b=eSs/LrJcdJCvAasLCE8EVuqlAZR2Sl6xOJjdr4sRYS3ASzPA6v8wF5WTDKrd5dy+en
         kL6icBDrLUIWQ9BikO/oJnHul3AJHyg/Tk439Vy1Mh7Z9qtQkLEk6htiVT3YXeqP7oL4
         /xGFZ6J9BWk6DsAP750LT61HtX/hErHacfmadOBsTvd9Z6sd+iUezzyremNSw8lD9SeN
         /0/TBH+77P+15el3RElRt1cvAPYrEUSN9OcpjOpGAaOkMsAZjcnkDzdwWSWfRF21cOqr
         DJ2K5RDnzzjKqFGx21QmoxZZYADlFOe/1qwiobvw3YZ3OfJ7kgd/9kKJwvOIoCOtYaKa
         Ruhw==
X-Gm-Message-State: AOAM530HjJjcca5FD/58SSA0qTKtFOvzb0sa5lQZ4CQ5pUqfMwjjIE+3
        O2B+XwdkMmSAK0JT50idBJMfbHi5ENhP9ViRJ1Yz6hchX1A=
X-Google-Smtp-Source: ABdhPJz1jqHfTGXWAqBzCi0XLWOAcxxHMafDcBBKN8t0yrh7MkePuOmHgmpcehWs/qR2uUsGj2HW9D6C3JhWBy4wUcI=
X-Received: by 2002:adf:9d83:0:b0:20d:129f:6544 with SMTP id
 p3-20020adf9d83000000b0020d129f6544mr20990940wre.568.1653358548657; Mon, 23
 May 2022 19:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220518225531.558008-1-sdf@google.com> <20220518225531.558008-12-sdf@google.com>
 <CAEf4BzaG2bOcyVfGZxcNU1p8i0Xipez7v-789bq8qYDE1Ce-sQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaG2bOcyVfGZxcNU1p8i0Xipez7v-789bq8qYDE1Ce-sQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 23 May 2022 19:15:37 -0700
Message-ID: <CAKH8qBsQH2fwxa6B6LOqfw1ru_qk9wyypXnAzy4u+uBYBmQq8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 11/11] selftests/bpf: verify lsm_cgroup struct
 sock access
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 23, 2022 at 4:33 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 3:56 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > sk_priority & sk_mark are writable, the rest is readonly.
> >
> > One interesting thing here is that the verifier doesn't
> > really force me to add NULL checks anywhere :-/
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/lsm_cgroup.c     | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> > index 29292ec40343..64b6830e03f5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> > @@ -270,8 +270,77 @@ static void test_lsm_cgroup_functional(void)
> >         lsm_cgroup__destroy(skel);
> >  }
> >
> > +static int field_offset(const char *type, const char *field)
> > +{
> > +       const struct btf_member *memb;
> > +       const struct btf_type *tp;
> > +       const char *name;
> > +       struct btf *btf;
> > +       int btf_id;
> > +       int i;
> > +
> > +       btf = btf__load_vmlinux_btf();
> > +       if (!btf)
> > +               return -1;
> > +
> > +       btf_id = btf__find_by_name_kind(btf, type, BTF_KIND_STRUCT);
> > +       if (btf_id < 0)
> > +               return -1;
> > +
> > +       tp = btf__type_by_id(btf, btf_id);
> > +       memb = btf_members(tp);
> > +
> > +       for (i = 0; i < btf_vlen(tp); i++) {
> > +               name = btf__name_by_offset(btf,
> > +                                          memb->name_off);
> > +               if (strcmp(field, name) == 0)
> > +                       return memb->offset / 8;
> > +               memb++;
> > +       }
> > +
> > +       return -1;
> > +}
> > +
> > +static bool sk_writable_field(const char *type, const char *field, int size)
> > +{
> > +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > +                   .expected_attach_type = BPF_LSM_CGROUP);
> > +       struct bpf_insn insns[] = {
> > +               /* r1 = *(u64 *)(r1 + 0) */
> > +               BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
> > +               /* r1 = *(u64 *)(r1 + offsetof(struct socket, sk)) */
> > +               BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, field_offset("socket", "sk")),
> > +               /* r2 = *(u64 *)(r1 + offsetof(struct sock, <field>)) */
> > +               BPF_LDX_MEM(size, BPF_REG_2, BPF_REG_1, field_offset(type, field)),
> > +               /* *(u64 *)(r1 + offsetof(struct sock, <field>)) = r2 */
> > +               BPF_STX_MEM(size, BPF_REG_1, BPF_REG_2, field_offset(type, field)),
> > +               BPF_MOV64_IMM(BPF_REG_0, 1),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       int fd;
>
> This is really not much better than test_verifier assembly. What I had
> in mind when I was suggesting to use test_progs was that you'd have a
> normal C source code for BPF part, something like this:
>
> __u64 tmp;
>
> SEC("?lsm_cgroup/socket_bind")
> int BPF_PROG(access1_bad, struct socket *sock, struct sockaddr
> *address, int addrlen)
> {
>     *(volatile u16 *)(sock->sk.skc_family) = *(volatile u16
> *)sock->sk.skc_family;
>     return 0;
> }
>
>
> SEC("?lsm_cgroup/socket_bind")
> int BPF_PROG(access2_bad, struct socket *sock, struct sockaddr
> *address, int addrlen)
> {
>     *(volatile u64 *)(sock->sk.sk_sndtimeo) = *(volatile u64
> *)sock->sk.sk_sndtimeo;
>     return 0;
> }
>
> and so on. From user-space you'd be loading just one of those
> accessX_bad programs at a time (note SEC("?"))
>
>
> But having said that, what you did is pretty self-contained, so not
> too bad. It's just not what I was suggesting :)

Yeah, that's what I suggested I was gonna try in:
https://lore.kernel.org/bpf/CAKH8qBuHU7OAjTMk-6GU08Nmwnn6J7Cw1TzP6GwCEq0x1Wwd9w@mail.gmail.com/

I don't really want to separate the program from the test, it seems
like keeping everything in one file is easier to read.
So unless you strongly dislike this new self-contained version, I'd
keep it as is.



> > +
> > +       opts.attach_btf_id = libbpf_find_vmlinux_btf_id("socket_post_create",
> > +                                                       opts.expected_attach_type);
> > +
> > +       fd = bpf_prog_load(BPF_PROG_TYPE_LSM, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
> > +       if (fd >= 0)
> > +               close(fd);
> > +       return fd >= 0;
> > +}
> > +
> > +static void test_lsm_cgroup_access(void)
> > +{
> > +       ASSERT_FALSE(sk_writable_field("sock_common", "skc_family", BPF_H), "skc_family");
> > +       ASSERT_FALSE(sk_writable_field("sock", "sk_sndtimeo", BPF_DW), "sk_sndtimeo");
> > +       ASSERT_TRUE(sk_writable_field("sock", "sk_priority", BPF_W), "sk_priority");
> > +       ASSERT_TRUE(sk_writable_field("sock", "sk_mark", BPF_W), "sk_mark");
> > +       ASSERT_FALSE(sk_writable_field("sock", "sk_pacing_rate", BPF_DW), "sk_pacing_rate");
> > +}
> > +
> >  void test_lsm_cgroup(void)
> >  {
> >         if (test__start_subtest("functional"))
> >                 test_lsm_cgroup_functional();
> > +       if (test__start_subtest("access"))
> > +               test_lsm_cgroup_access();
> >  }
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >

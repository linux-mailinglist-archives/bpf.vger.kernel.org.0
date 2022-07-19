Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06257AA60
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGSXUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiGSXUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 19:20:41 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629A3D5B3
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 16:20:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id r17-20020a056a00217100b0052ab8271e11so5049257pff.22
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A2tUsaNDJZUPOQ0PG4aQCdMfZAwBVfGqsNC8MMGsH8s=;
        b=C4GEWLXEqmafU6yXu7qcN/RIoODPDtcUqgLM/V4zN+RA5n4Du8j3vkgAXT0AH2Aj5X
         pWIX6eIPS0OHb90jTttA5aHmuS3bGiVcTHWttFgwUFHwjKCh1/LA+k8P+gadA1d7o3Hh
         lo2678K8KAFPhaTtJ+jSrSVlw6jdI5tGkfuq/jNwJ/Aihvc6u9+ztCim4nYMNFXlVWRD
         CaZKkdQ4FxmbCiw08QjsbTzOKXRihMo8m2fTMbD7pquNHxo3RLTNdiIiJ34E67PTrjJW
         uTDTg2+cl6jGT+kxIz5pZwH+7tx2fbLMwsn4coNpvWqeDbeTEX6Qn/kCCKZPO+HfWlLd
         szvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A2tUsaNDJZUPOQ0PG4aQCdMfZAwBVfGqsNC8MMGsH8s=;
        b=rQBeIV+1PyhvBVVtwh7tb0tDUbVwFoXc1+Mmgw3oUqzNW7qmet51Hw/QZipsoKd08U
         2NHT0ilODLlEbw5mvfT9u7c7dAbQzk7AxhK9otfT4Z3vzCjPez3Agd7Vn4gKOwx0vxQl
         pSmF1FtTCJOPdiB9r9aBdKlnWZhsATLprzlPjMtp+YT0uZaGT8aWttfbfQyLrNsOtdEo
         2yKfVw/vFgiymTV8e6XVD/ErMgamtU02mT+7/w45ckVmpWOhQ/GCpocKh9Pfzb1dSQTL
         tQQxN334vIT+KVB8Q2XG8Vwe9hcIgcFPewUBTIDLM8DAowyj/dZlQL4YWYWxv1AZRrTF
         xBdg==
X-Gm-Message-State: AJIora/92ARkm/MZifTAnHKcN/IMSVj/nRpkj0iGt7146MOuwj6oYlOp
        rpbGtMYFbp1m78Dl5CcOMdK41lc=
X-Google-Smtp-Source: AGRyM1tCWdRcO6acEW6UHeEf6l1vBPk7SynETdnVSOlGA2KQXc0MVbaj8owhaDBSrSpyXYqeYsfmZyc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:174f:b0:525:518e:71d6 with SMTP id
 j15-20020a056a00174f00b00525518e71d6mr36799767pfc.68.1658272840265; Tue, 19
 Jul 2022 16:20:40 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:20:38 -0700
In-Reply-To: <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
Message-Id: <Ytc8RvDTpEmC0pQD@google.com>
Mime-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
 <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com> <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
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

On 07/19, Alexei Starovoitov wrote:
> On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com>  
> wrote:
> > >
> > > On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev  
> <sdf@google.com> wrote:
> > > > >
> > > > > Motivation:
> > > > >
> > > > > Our bpf programs have a bunch of options which are set at the  
> loading
> > > > > time. After loading, they don't change. We currently use array map
> > > > > to store them and bpf program does the following:
> > > > >
> > > > > val = bpf_map_lookup_elem(&config_map, &key);
> > > > > if (likely(val && *val)) {
> > > > >   // do some optional feature
> > > > > }
> > > > >
> > > > > Since the configuration is static and we have a lot of those  
> features,
> > > > > I feel like we're wasting precious cycles doing dynamic lookups
> > > > > (and stalling on memory loads).
> > > > >
> > > > > I was assuming that converting those to some fake kconfig options
> > > > > would solve it, but it still seems like kconfig is stored in the
> > > > > global map and kconfig entries are resolved dynamically.
> > > > >
> > > > > Proposal:
> > > > >
> > > > > Resolve kconfig options statically upon loading. Basically rewrite
> > > > > ld+ldx to two nops and 'mov val, x'.
> > > > >
> > > > > I'm also trying to rewrite conditional jump when the condition is
> > > > > !imm. This seems to be catching all the cases in my program, but
> > > > > it's probably too hacky.
> > > > >
> > > > > I've attached very raw RFC patch to demonstrate the idea. Anything
> > > > > I'm missing? Any potential problems with this approach?
> > > >
> > > > Have you considered using global variables for that?
> > > > With skeleton the user space has a natural way to set
> > > > all of these knobs after doing skel_open and before skel_load.
> > > > Then the verifier sees them as readonly vars and
> > > > automatically converts LDX into fixed constants and if the code
> > > > looks like if (my_config_var) then the verifier will remove
> > > > all the dead code too.
> > >
> > > Hm, that's a good alternative, let me try it out. Thanks!
> >
> > Turns out we already freeze kconfig map in libbpf:
> > if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
> >         err = bpf_map_freeze(map->fd);
> >
> > And I've verified that I do hit bpf_map_direct_read in the verifier.
> >
> > But the code still stays the same (bpftool dump xlated):
> >   72: (18) r1 = map[id:24][0]+20
> >   74: (61) r1 = *(u32 *)(r1 +0)
> >   75: (bf) r2 = r9
> >   76: (b7) r0 = 0
> >   77: (15) if r1 == 0x0 goto pc+9
> >
> > I guess there is nothing for sanitize_dead_code to do because my
> > conditional is "if (likely(some_condition)) { do something }" and the
> > branch instruction itself is '.seen' by the verifier.

> I bet your variable is not 'const'.
> Please see any of the progs in selftests that do:
> const volatile int var = 123;
> to express configs.

Yeah, I was testing against the following:

	extern int CONFIG_XYZ __kconfig __weak;

But ended up writing this small reproducer:

	struct __sk_buff;

	const volatile int CONFIG_DROP = 1; // volatile so it's not
					    // clang-optimized

	__attribute__((section("tc"), used))
	int my_config(struct __sk_buff *skb)
	{
		int ret = 0; /*TC_ACT_OK*/

		if (CONFIG_DROP)
			ret = 2 /*TC_ACT_SHOT*/;

		return ret;
	}

$ bpftool map dump name my_confi.rodata

[{
         "value": {
             ".rodata": [{
                     "CONFIG_DROP": 1
                 }
             ]
         }
     }
]

$ bpftool prog dump xlated name my_config

int my_config(struct __sk_buff * skb):
; if (CONFIG_DROP)
    0: (18) r1 = map[id:3][0]+0
    2: (61) r1 = *(u32 *)(r1 +0)
    3: (b4) w0 = 1
; if (CONFIG_DROP)
    4: (64) w0 <<= 1
; return ret;
    5: (95) exit

The branch is gone, but the map lookup is still there :-(

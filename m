Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646545267C4
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382655AbiEMRAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382704AbiEMRA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 13:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8B6556FA4
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652461203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpuYzgBorX/kwU/c/lW2Z6Gvah66kJD+vnpuI+T23y0=;
        b=ZjSw/Kt0m3gT7B9CM39kNSvwb7WWjc2KIqgEwAGSw9yhYCZFykV5BRlhtXOL/enBY82wJX
        j2LWTS5mAIvSaJ6mxh7FAPNZCnlVBPzcPXMZ31UDAcd8Yi1ZoUAaDrxjtjAc4JcP3YD8dr
        T8KsAxfYbdbzphNCBNDCxO6m+nmBP2Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-OTXGfsmANoOE7WyDKreZdA-1; Fri, 13 May 2022 13:00:02 -0400
X-MC-Unique: OTXGfsmANoOE7WyDKreZdA-1
Received: by mail-pf1-f199.google.com with SMTP id p18-20020aa78612000000b0050d1c170018so4303529pfn.15
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpuYzgBorX/kwU/c/lW2Z6Gvah66kJD+vnpuI+T23y0=;
        b=1IRkl0J6bih7VSIxEMdlXK6UBPrSWhrNvpZ20U+8lnEP8uoyINptq5FC/P/PM8cXx6
         KwtaCFrhPGeOuprkQBtCkNrjctRJW1s+9/x79N1QKkZIpBUw2AXDgRAgUbUD68/73e+n
         jXlcOl9IjEO001otiiuI4n2atksqhrUFWzu6VfwvCJzoWDVTBvEesv7sGHMjWQ6YjSU8
         EHoOpsm3n2/7gWw+7j4LpmMHl9mxoM+toLnLRuZl4lodPUsLCoqG2/xfBZWceGfWQ3dH
         vMLPPt0J88ZDa6Mr98MTvepg+KRceQwOnVOtPIp4BSxwZoSRcnh1FGhLsgsmbxKl3Ih7
         uK2g==
X-Gm-Message-State: AOAM533enkJKVm7hWSV0Gz6ymH9RhdhwFLrZs1pV5vvUBUJTd0nEJ6rj
        F//lez7gmKF2LGIp+u1T5GIBKjQgEeJ7Lc2L865szNMcVmsp2pCYF0dLNbGybn7jrytQcuige/b
        j9oUW5k5s/c7TFRxFXgy0ESVLykdI
X-Received: by 2002:a17:902:c409:b0:15e:bdd3:1fa3 with SMTP id k9-20020a170902c40900b0015ebdd31fa3mr5717810plk.67.1652461201169;
        Fri, 13 May 2022 10:00:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxYPLBt2FygMLbms5fdpQp73R6KNFy6xEnXpNuEWrxiYEE+9ffF3nAYo0W88LztvGQb6RY0gwS7vQ/NHptIcY=
X-Received: by 2002:a17:902:c409:b0:15e:bdd3:1fa3 with SMTP id
 k9-20020a170902c40900b0015ebdd31fa3mr5717783plk.67.1652461200888; Fri, 13 May
 2022 10:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
 <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
 <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
 <CAO-hwJ+bAJb_1jSu30hnjfF1u8HZVMCqKU4qTJg=XUhupok13g@mail.gmail.com> <20220512041607.zloscyl3k5z3sdp2@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220512041607.zloscyl3k5z3sdp2@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 13 May 2022 18:59:50 +0200
Message-ID: <CAO-hwJ+N5ofYSZG=SfRE+O77aXTwoDxr6SkoY_QorRBEVz_=ew@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 6:16 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 02, 2022 at 11:43:51PM +0200, Benjamin Tissoires wrote:
> > On Sat, Apr 30, 2022 at 9:12 AM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > [...]
> > > This is roughly what I have now:
> > >
> > > - hid-core is not aware of BPF except for a few __weak
> > > ALLOW_ERROR_INJECTION hooks (dispatch_hid_bpf_device_event for
> > > example)
> > > - I have a separate hid-bpf module that attaches BPF traces to these
> > > hooks and calls a "dispatch" kfunc within hid-bpf
> > > - the dispatch function then do a succession of BPF calls to programs
> > > attached to it by using bpf_tail_call(prog_array, hid_id)
> > >
> > > - for the clients, they define one or more
> > > SEC("fmod_ret/hid_bpf_device_event"). That __weak hook is declared in
> > > the kernel by hid-bpf but is never called, it's just an API
> > > declaration
> > > - then clients call in a SEC("syscall")
> > > hid_bpf_attach_prog(ctx->prog_fd, ctx->hid_id, ctx->flags);
> > > - hid_bpf_attach_prog is a kfunc that takes a ref on the struct
> > > bpf_prog*, and stores that program in the correct struct bpf_map *for
> > > the given attached_btf_id (hid_bpf_device_event in our case)
> > >
> > > And that's about it.
> > > I still need to handle automatic release of the bpf prog when there is
> > > no userspace open fd on it unless it's pinned but I think this should
> > > be working fine.
> > >
> > > I also probably need to pin some SEC("syscall") (hid_bpf_attach_prog
> > > and hid_bpf_dettach_prog) so users don't have to write them down and
> > > can just use the ones provided by the kernel.
> > >
> > > The nice thing is that I can define my own API for the attach call
> > > without dealing with bpf core. I can thus add a priority flag that is
> > > relevant here because the data coming through the bpf program can be
> > > modified.
> > >
> > > The other thing is that now, I don't care which function we are in to
> > > decide if a RET_PTR_MEM is read only or not. I can deal with that by
> > > either playing with the flags or even replacing entirely the dispatch
> > > trace prog from userspace if I want to access the raw events.
> > >
> > > However, the downsides are:
> > > - I need to also define kfuncs for BPF_PROG_TYPE_SYSCALL (I don't
> > > think It'll be a big issue)
> > > - The only way I could store the bpf_prog into the map was to hack
> > > around the map ops, because the fd of the map in the skel is not
> > > available while doing a SEC("syscall") from a different process.
> >
> > Update on this side: I realized that I could use the syscall
> > BPF_MAP_GET_FD_BY_ID instead to get an fd for the current task.
> > However, I've been bitten quite hard today because I was using
> > bpf_map_get() instead of bpf_map_get_with_uref(), and so every time I
> > closed the fd in the syscall the map was cleared...
> >
> > But now I would like to have more than one program of a type per hid
> > device, meaning that I can not have only one bpf_map of type
> > BPF_MAP_TYPE_PROG_ARRAY.
> > I have explored BPF_MAP_TYPE_HASH_OF_MAPS, but we can not have
> > BPF_MAP_TYPE_PROG_ARRAY as inner maps with the current code. And I'd
> > need 2 levels of nesting (which is not authorized today):
> > - hid_jmp_table (key: HID id)
> >   - array of different program type per HID device (key: HID_BPF_PROG_TYPE)
> >     - BPF_MAP_TYPE_PROG_ARRAY with the actual progs (key: int)
> >
> > The other solution would be to be able to create a map when needed,
> > store it in struct hid_device, and then call bpf_tail_call on this
> > map. The problem is that I need a way to teach the verifier that the
> > struct bpf_map pointer I have in the context is a true bpf_map...
>
> We have kptr feature now.
> So bpf progs can store pointers to specific kernel data structures
> inside map values.
> Storing 'struct bpf_map *' in a map value would be something :)
> Circular dependency issues to address. Maybe it's doable.
>
> Would hash based prog_array work ?
> Then the key can be an arbitrary combination.
> There is fd_htab logic. It's used for map-in-map.
> We can tweak it to store progs in a hash map.
>

In the end, I am just using a global prog_array map, and handling the
indexes myself. It is probably not the cleaner and the most reusable,
but it allows me at least to move forward.

FWIW, I should be able to send v5 next week. I am almost done
reimplementing everything I had in v3, and I am now fighting with
hid.ko as a module (should be solved soon enough).

Cheers,
Benjamin


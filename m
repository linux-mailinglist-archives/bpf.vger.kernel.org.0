Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004DC5243FB
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 06:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbiELEQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 00:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbiELEQO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 00:16:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8795326FE;
        Wed, 11 May 2022 21:16:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n10so4033899pjh.5;
        Wed, 11 May 2022 21:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=njnm+5q69Pmp4J8AZTtVnxa3kk6USj4AeKvHVB8XgQw=;
        b=A5GpeDL3Y/vOESjKhgsMkONDjrcTMkfd+YryDxIevcUQih7OGFuTxKO/opYeJG710f
         mhWVKOTMDsBkWXzLMridCHmNug1iBxcjHqITFzX1yJ05deO1S19tVJgozLpmYY09Gpcf
         NxUqfxRI2jjxyj6w62LCdJqBgeNz+0GWroVoVlgDMpnOsrXGcOW23v4Er72dABr47aOu
         NzF/UKMVfsXy/rpoj4vuWOIHmo6Wu0L20vJFQ/Vw5suhDCGJ7B1zt9fQ4VGCfd6mr0EE
         zWzTZN0kXTSREJeb2SdYigNOcwpWPliKj7gThmyhab6I9xSSKhC+gX3NAUIBA7aHo3IO
         lE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=njnm+5q69Pmp4J8AZTtVnxa3kk6USj4AeKvHVB8XgQw=;
        b=FhQUWTNsIBm/zhpfbToveij+1P97M350ZgvzxhYRHOAdxQAm4AX+hJPbTOHrDp6hBC
         7Qe9z7lnFlMLIU9edskUVD7tOCkrRczJ1G7nlIPDW9RgDw31zxaC337J6isccaD0YRea
         /rMMtjh70Ixdm5RCv1rkhVSSwE/INMpX5FVuxMvSJuETXdkMRgPaPfL6Tr4ki+paID4/
         StdGmPHpYMzoGQG1MPDY9ICzhvCwr5JHiLKC0X9QFjSkLp+V8jwvGsavF9vR6n4lwzzJ
         S66SYjzZKTOEyo7W1FCRkg/3ciAY5+H/5gzTUvS680r16oKnEDY2v0+9INbnK/pwDKaK
         lQsQ==
X-Gm-Message-State: AOAM532I4yMmJ+/itxkmJYAG0tgOzxIkayxH137SrBIkpiY11TxvIIRD
        MsG4D9efZodERu0ZscE529od8aVWdZY=
X-Google-Smtp-Source: ABdhPJxgqqMdXXv2qdtIGHlAGxFfMp/xg0hIfOTt4QcU7L5te1YlgjhyCoI+46d9tIpdfO2Kl3h7cQ==
X-Received: by 2002:a17:90b:3d0b:b0:1dc:1953:462d with SMTP id pt11-20020a17090b3d0b00b001dc1953462dmr8853371pjb.122.1652328971222;
        Wed, 11 May 2022 21:16:11 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:6b86])
        by smtp.gmail.com with ESMTPSA id 71-20020a63014a000000b003c1bf4c064fsm703941pgb.72.2022.05.11.21.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:16:10 -0700 (PDT)
Date:   Wed, 11 May 2022 21:16:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
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
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices
 (new attempt)
Message-ID: <20220512041607.zloscyl3k5z3sdp2@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
 <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
 <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
 <CAO-hwJ+bAJb_1jSu30hnjfF1u8HZVMCqKU4qTJg=XUhupok13g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+bAJb_1jSu30hnjfF1u8HZVMCqKU4qTJg=XUhupok13g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 02, 2022 at 11:43:51PM +0200, Benjamin Tissoires wrote:
> On Sat, Apr 30, 2022 at 9:12 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> [...]
> > This is roughly what I have now:
> >
> > - hid-core is not aware of BPF except for a few __weak
> > ALLOW_ERROR_INJECTION hooks (dispatch_hid_bpf_device_event for
> > example)
> > - I have a separate hid-bpf module that attaches BPF traces to these
> > hooks and calls a "dispatch" kfunc within hid-bpf
> > - the dispatch function then do a succession of BPF calls to programs
> > attached to it by using bpf_tail_call(prog_array, hid_id)
> >
> > - for the clients, they define one or more
> > SEC("fmod_ret/hid_bpf_device_event"). That __weak hook is declared in
> > the kernel by hid-bpf but is never called, it's just an API
> > declaration
> > - then clients call in a SEC("syscall")
> > hid_bpf_attach_prog(ctx->prog_fd, ctx->hid_id, ctx->flags);
> > - hid_bpf_attach_prog is a kfunc that takes a ref on the struct
> > bpf_prog*, and stores that program in the correct struct bpf_map *for
> > the given attached_btf_id (hid_bpf_device_event in our case)
> >
> > And that's about it.
> > I still need to handle automatic release of the bpf prog when there is
> > no userspace open fd on it unless it's pinned but I think this should
> > be working fine.
> >
> > I also probably need to pin some SEC("syscall") (hid_bpf_attach_prog
> > and hid_bpf_dettach_prog) so users don't have to write them down and
> > can just use the ones provided by the kernel.
> >
> > The nice thing is that I can define my own API for the attach call
> > without dealing with bpf core. I can thus add a priority flag that is
> > relevant here because the data coming through the bpf program can be
> > modified.
> >
> > The other thing is that now, I don't care which function we are in to
> > decide if a RET_PTR_MEM is read only or not. I can deal with that by
> > either playing with the flags or even replacing entirely the dispatch
> > trace prog from userspace if I want to access the raw events.
> >
> > However, the downsides are:
> > - I need to also define kfuncs for BPF_PROG_TYPE_SYSCALL (I don't
> > think It'll be a big issue)
> > - The only way I could store the bpf_prog into the map was to hack
> > around the map ops, because the fd of the map in the skel is not
> > available while doing a SEC("syscall") from a different process.
> 
> Update on this side: I realized that I could use the syscall
> BPF_MAP_GET_FD_BY_ID instead to get an fd for the current task.
> However, I've been bitten quite hard today because I was using
> bpf_map_get() instead of bpf_map_get_with_uref(), and so every time I
> closed the fd in the syscall the map was cleared...
> 
> But now I would like to have more than one program of a type per hid
> device, meaning that I can not have only one bpf_map of type
> BPF_MAP_TYPE_PROG_ARRAY.
> I have explored BPF_MAP_TYPE_HASH_OF_MAPS, but we can not have
> BPF_MAP_TYPE_PROG_ARRAY as inner maps with the current code. And I'd
> need 2 levels of nesting (which is not authorized today):
> - hid_jmp_table (key: HID id)
>   - array of different program type per HID device (key: HID_BPF_PROG_TYPE)
>     - BPF_MAP_TYPE_PROG_ARRAY with the actual progs (key: int)
> 
> The other solution would be to be able to create a map when needed,
> store it in struct hid_device, and then call bpf_tail_call on this
> map. The problem is that I need a way to teach the verifier that the
> struct bpf_map pointer I have in the context is a true bpf_map...

We have kptr feature now.
So bpf progs can store pointers to specific kernel data structures
inside map values.
Storing 'struct bpf_map *' in a map value would be something :)
Circular dependency issues to address. Maybe it's doable.

Would hash based prog_array work ?
Then the key can be an arbitrary combination.
There is fd_htab logic. It's used for map-in-map.
We can tweak it to store progs in a hash map.

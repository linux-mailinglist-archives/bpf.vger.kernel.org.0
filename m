Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729BA29F8A0
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 23:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2Wsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 18:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Wsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 18:48:50 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C378FC0613CF
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 15:48:50 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a4so3514257ybq.13
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ewd+KAypAFGWQ9yv2OHFGvh1tNM+4d08SWTY0uAhLBk=;
        b=Sr8DQ1rdTSHS4CnCW2oeOvd3v5UguvvMnynKoS0AeMsxc5lg6SrqdfFIcEov3wr9Br
         GlaTvqLY0wr9WFKEk9mrKZPGMtJFeBaMTGmdwf6DtQqmmkWDHwF6r5ln/6lezWum5/WN
         cYcvoKa4ALgTtIbwraRogCRRDPj2GHqBgRs9CAE7ACMb3/e5OVD3T5nY3034S24V97M9
         bZ16nz8onlmVpN8AS+1U1AGNpFLrJgy+e5hJxrXH63Ledd2qYrpi8VVeo+4PBK/gVpC+
         sekLFRdlkmjFH5ROZVTj2yJ0DL+572I7/aLoLnT77hC7nYoN9HRz+a9z8weim8Sqh9IE
         UmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ewd+KAypAFGWQ9yv2OHFGvh1tNM+4d08SWTY0uAhLBk=;
        b=BondvcwYQW1dFi6rXDRrJ/SYOvcCqbSEUa1UDp09/2F8z+H/jR0yTWFNoh4T3UJ4JE
         HKagNWGACl19nyBSKQdNdwgc2UNxHw1lMaEcPsQ6Z3NnSz/L7GU1V0g4JtJ9RM/1anVG
         qL1A/qcmSmIRyDojbt0y+c0XRPDeF1jmGebsXyaLJpMS2A5TiDoHq/79QOTzt5Bcu2kM
         qzanWOEmyWbaM38oH3Fv62XHB6SVit42DqBJbrwBGEUlOqL2F6CsZuvFRPqqxdi1irkQ
         txzx98Cs5yuI2ykQtq3lXuJz44z6WhxdRrphsfBNnabORlHFaydEqID30UrEVoZDN2g6
         iwxQ==
X-Gm-Message-State: AOAM533pF+kBB+W2AMsw95DVDrwX2gnn4jsO8FQ2ziA5+7WCfWTplH8o
        raajEk3nJ0n66DPuVHLrpzB7HVhqq0MrXOJ/5Ww=
X-Google-Smtp-Source: ABdhPJx82PrUhfpEtaVJTjcVJtyLpeWgXYgfg+R9SXVMwfD/I8H9hvRTv+j8O+xK6hlH+n1ckhkbMYvVVO90x2qK5lM=
X-Received: by 2002:a25:3443:: with SMTP id b64mr9230046yba.510.1604011729553;
 Thu, 29 Oct 2020 15:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
 <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
 <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <CAEf4BzZj8z5YWHQkYBjBuQ2LUwvodt7tz_9=GZzZ6hcW3zkj5g@mail.gmail.com>
 <HE1PR83MB0220B3D0413E997D1A33FA52FB770@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <VI1PR8303MB00808A980F003A9F403E413EFB190@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CAEf4BzYOrZ4swcobfjJ3Or5Pp--4dNkv8JwhJXjQfCPao-Xpvw@mail.gmail.com>
 <CACYkzJ4DU2AkMqvfZ0JDBGE4XPep2Lu2mo6muy1zqk-Y7esh5w@mail.gmail.com>
 <CAEf4BzazZQ_Y5S9kG=JV12M7gH0XoTkMViWncOqs6Q+qGNmvdg@mail.gmail.com> <VI1PR8303MB0080F418C63C77C827339297FB170@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
In-Reply-To: <VI1PR8303MB0080F418C63C77C827339297FB170@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Oct 2020 15:48:38 -0700
Message-ID: <CAEf4Bzb6KuX1MdnkT9SEPxFx2bmbkRJOPfUjqgmHrGT262JZ_w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 12:03 PM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> > -----Original Message-----
> > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Sent: 27 October 2020 03:44
> >
> > On Mon, Oct 26, 2020 at 6:07 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > On Mon, Oct 26, 2020 at 11:01 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 26, 2020 at 10:10 AM Kevin Sheldrake
> > > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > > >
> > > > > Hello Andrii and list
> > > > >
> > > > > I've now had chance to properly investigate the perf ring buffer
> > corruption bug.  Essentially (as suspected), the size parameter that is
> > specified as a __u64 in bpf_helper_defs.h, is truncated into a __u16 inside
> > the struct perf_event_header size parameter
> > ($KERNELSRC/include/uapi/linux/perf_event.h and
> > /usr/include/linux/perf_event.h).
> > > > >
> <SNIP>
>
> > > The size argument is of the type ARG_CONST_SIZE_OR_ZERO:
> > >
> > > static const struct bpf_func_proto bpf_perf_event_output_proto = {
> > >    .func = bpf_perf_event_output,
> > >    .gpl_only = true,
> > >    .ret_type = RET_INTEGER,
> > >    .arg1_type = ARG_PTR_TO_CTX,
> > >    .arg2_type = ARG_CONST_MAP_PTR,
> > >    .arg3_type = ARG_ANYTHING,
> > >    .arg4_type = ARG_PTR_TO_MEM,
> > >    .arg5_type = ARG_CONST_SIZE_OR_ZERO, };
> > >
> > > and we do similar checks in the verifier with the BPF_MAX_VAR_SIZ:
> > >
> > > if (reg->umax_value >= BPF_MAX_VAR_SIZ) {
> > >    verbose(env, "R%d unbounded memory access, use 'var &= const' or
> > > 'if (var < const)'\n",
> > >       regno);
> > >    return -EACCES;
> > > }
> >
> > You are right, of course, my bad. Verifier might not know the exact value, but
> > it enforces the upper bound. So in this case we can additionally enforce extra
> > upper bound for bpf_perf_event_output().
> > Though, given this will require kernel upgrade, I'd just stick to BPF ringbuf at
> > that point ;)
> >
> > >
> > > it's just that bpf_perf_event_output expects the size to be even
> > > smaller than 32 bits (i.e. 16 bits).
> > >
> > > > BPF verifier can't do much about that. It seems like the proper
> > > > solution is to do the check in bpf_perf_event_output() BPF helper
> > > > itself. Returning -E2BIG is an appropriate behavior here, rather
> > > > than
> > >
> > > This could be a solution (and maybe better than the verifier check).
> > >
> > > But I do think perf needs to have the check instead of
> > bpf_perf_event_output:
> >
> > Yeah, of course, perf subsystem itself shouldn't allow data corruption. My
> > point was to do it as a runtime check, rather than enforce at verification time.
> > But both would work fine.
>
> Appreciate this is a fix in the verifier and not the perf subsystem, but would something like this be acceptable?
>
> /usr/src/linux$ diff include/linux/bpf_verifier.h.orig include/linux/bpf_verifier.h
> 19a20,24
> > /* Maximum variable size permitted for size param to bpf_perf_event_output().
> >  * This ensures the samples sent into the perf ring buffer do not overflow the
> >  * size parameter in the perf event header.
> >  */
> > #define BPF_MAX_PERF_SAMP_SIZ ((1 << (sizeof(((struct perf_event_header *)0)->size) * 8)) - 24)
> /usr/src/linux$ diff kernel/bpf/verifier.c.orig kernel/bpf/verifier.c
> 4599c4599
> <       struct bpf_reg_state *regs;
> ---
> >       struct bpf_reg_state *regs, *reg;
> 4653a4654,4662

you didn't use unified diff format, so it's hard to tell where exactly
you made this change. But please post a proper patch and let's review
it properly.

> >       /* special check for bpf_perf_event_output() size */
> >       regs = cur_regs(env);
> >       reg = &regs[BPF_REG_5];
> >       if (func_id == BPF_FUNC_perf_event_output && reg->umax_value >= BPF_MAX_PERF_SAMP_SIZ) {
> >               verbose(env, "bpf_perf_output_event()#%d size parameter must be less than %ld\n",
> >                       BPF_FUNC_perf_event_output, BPF_MAX_PERF_SAMP_SIZ);
> >               return -E2BIG;
> >       }
> >
> 4686,4687d4694
> <
> <       regs = cur_regs(env);
>
> I couldn't find the details on the size of the header/padding for the sample.  The struct perf_event_header is 16 bytes, whereas the struct perf_raw_record mentioned below is 40 bytes, but the actual value determined by experimentation is 24.
>
> If acceptable, and given that it protects the perf ring buffer from corruption, could it be a candidate for back-porting?
>
> Thanks
>
> Kev
>
>
>
>
>
> >
> > >
> > > The size in the perf always seems to be u32 except the
> > > perf_event_header (I assume this is to save some space on the ring
> > > buffer)
> >
> > Probably saving space, yeah. Though it's wasting 3 lower bits because all sizes
> > seem to be multiple of 8 always. So could the real limit could be 8 * 64K =
> > 512KB, easily. But it's a bit late now.
> >
> > >
> > > struct perf_raw_frag {
> > >      union {
> > >          struct perf_raw_frag *next;
> > >          unsigned long pad;
> > >      };
> > >     perf_copy_f copy;
> > >     void *data;
> > >     u32 size;
> > > } __packed;
> > >
> > > struct perf_raw_record {
> > >    struct perf_raw_frag frag;
> > >     u32 size;
> > > };
> > >
> > > Maybe we can just add the check to perf_event_output instead?
> > >
> > > - KP
> > >
> > > > corrupting data. __u64 if helper definition is fine as well, because
> > > > that's the size of BPF registers that are used to pass arguments to
> > > > helpers.
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > Kevin Sheldrake
> > > > >
> > > > > PS I will get around to the clang/LLVM jump offset warning soon I
> > promise.
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On
> > > > > > Behalf Of Kevin Sheldrake
> > > > > > Sent: 24 July 2020 10:40
> > > > > > To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: bpf@vger.kernel.org
> > > > > > Subject: RE: [EXTERNAL] Re: Maximum size of record over perf ring
> > buffer?
> > > > > >
> > > > > > Hello Andrii
> > > > > >
> > > > > > Thank you for taking a look at this.  While the size is reported
> > > > > > correctly to the consumer (bar padding, etc), the actual offsets
> > > > > > between adjacent pointers appears to either have been cast to a
> > > > > > u16 or otherwise masked with 0xFFFF, causing what I believe to
> > > > > > be overlapping samples and the opportunity for sample corruption in
> > the overlapped regions.
> > > > > >
> > > > > > Thanks again
> > > > > >
> > > > > > Kev
> > > > > >
> > > > > >
> > > > > > -----Original Message-----
> > > > > > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Sent: 23 July 2020 20:05
> > > > > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > > > > Cc: bpf@vger.kernel.org
> > > > > > Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring
> > buffer?
> > > > > >
> > > > > > On Mon, Jul 20, 2020 at 4:39 AM Kevin Sheldrake
> > > > > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > > > > >
> > > > > > > Hello
> > > > > > >
> > > > > > > Thank you for your response; I hope you don't mind me
> > > > > > > top-posting.  I've
> > > > > > put together a POC that demonstrates my results.  Edit the size
> > > > > > of the data char array in event_defs.h to change the behaviour.
> > > > > > >
> > > > > > >
> > > > > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > > 2Fgith
> > > > > > > ub.com%2Fmicrosoft%2FOMS-Auditd-Plugin%2Ftree%2FMSTIC-
> > > > > > Research%2Febpf_
> > > > > > >
> > > > > >
> > perf_output_poc&amp;data=02%7C01%7CKevin.Sheldrake%40microsoft.c
> > > > > > o
> > > > > > m%7C8
> > > > > > >
> > > > > >
> > bd9fb551cd4454b87a608d82f3b57c0%7C72f988bf86f141af91ab2d7cd011db
> > > > > > 47
> > > > > > %7C1
> > > > > > >
> > > > > >
> > %7C0%7C637311279211606351&amp;sdata=jMMpfi%2Bd%2B7jZzMT905xJ61
> > > > > > 34cDJd5u
> > > > > > > MNSu9RCdx4M6s%3D&amp;reserved=0
> > > > > >
> > > > > > I haven't run your program, but I can certainly reproduce this
> > > > > > using bench_perfbuf in selftests. It does seem like something is
> > > > > > silently corrupted, because the size reported by perf is correct
> > > > > > (plus/minus few bytes, probably rounding up to 8 bytes), but the
> > > > > > contents is not correct. I have no idea why that's happening,
> > > > > > maybe someone more familiar with the perf subsystem can take a
> > look.
> > > > > >
> > > > > > >
> > > > > > > Unfortunately, our project aims to run on older kernels than
> > > > > > > 5.8 so the bpf
> > > > > > ring buffer won't work for us.
> > > > > > >
> > > > > > > Thanks again
> > > > > > >
> > > > > > > Kevin Sheldrake
> > > > > > >
> > > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org>
> > On
> > > > > > Behalf
> > > > > > > Of Andrii Nakryiko
> > > > > > > Sent: 20 July 2020 05:35
> > > > > > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > > > > > Cc: bpf@vger.kernel.org
> > > > > > > Subject: [EXTERNAL] Re: Maximum size of record over perf ring
> > buffer?
> > > > > > >
> > > > > > > On Fri, Jul 17, 2020 at 7:24 AM Kevin Sheldrake
> > > > > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > > > > > >
> > > > > > > > Hello
> > > > > > > >
> > > > > > > > I'm building a tool using EBPF/libbpf/C and I've run into an
> > > > > > > > issue that I'd
> > > > > > like to ask about.  I haven't managed to find documentation for
> > > > > > the maximum size of a record that can be sent over the perf ring
> > > > > > buffer, but experimentation (on kernel 5.3 (x64) with latest
> > > > > > libbpf from github) suggests it is just short of 64KB.  Please
> > > > > > could someone confirm if that's the case or not?  My experiments
> > > > > > suggest that sending a record that is greater than 64KB results
> > > > > > in the size reported in the callback being correct but the
> > > > > > records overlapping, causing corruption if they are not serviced
> > > > > > as quickly as they arrive.  Setting the record to exactly 64KB results in
> > no records being received at all.
> > > > > > > >
> > > > > > > > For reference, I'm using perf_buffer__new() and
> > > > > > > > perf_buffer__poll() on
> > > > > > the userland side; and bpf_perf_event_output(ctx, &event_map,
> > > > > > BPF_F_CURRENT_CPU, event, sizeof(event_s)) on the EBPF side.
> > > > > > > >
> > > > > > > > Additionally, is there a better architecture for sending
> > > > > > > > large volumes of
> > > > > > data (>64KB) back from the EBPF program to userland, such as a
> > > > > > different ring buffer, a map, some kind of shared mmaped
> > > > > > segment, etc, other than simply fragmenting the data?  Please
> > > > > > excuse my naivety as I'm relatively new to the world of EBPF.
> > > > > > > >
> > > > > > >
> > > > > > > I'm not aware of any such limitations for perf ring buffer and
> > > > > > > I haven't had a
> > > > > > chance to validate this. It would be great if you can provide a
> > > > > > small repro so that someone can take a deeper look, it does
> > > > > > sound like a bug, if you really get clobbered data. It might be
> > > > > > actually how you set up perfbuf, AFAIK, it has a mode where it
> > > > > > will override the data, if it's not consumed quickly enough, but you
> > need to consciously enable that mode.
> > > > > > >
> > > > > > > But apart from that, shameless plug here, you can try the new
> > > > > > > BPF ring
> > > > > > buffer ([0]), available in 5.8+ kernels. It will allow you to
> > > > > > avoid extra copy of data you get with bpf_perf_event_output(),
> > > > > > if you use BPF ringbuf's
> > > > > > bpf_ringbuf_reserve() + bpf_ringbuf_commit() API. It also has
> > > > > > bpf_ringbuf_output() API, which is logically  equivalent to
> > > > > > bpf_perf_event_output(). And it has a very high limit on sample
> > > > > > size, up to 512MB per sample.
> > > > > > >
> > > > > > > Keep in mind, BPF ringbuf is MPSC design and if you use just
> > > > > > > one BPF
> > > > > > ringbuf across all CPUs, you might run into some contention
> > > > > > across multiple CPU. It is acceptable in a lot of applications I
> > > > > > was targeting, but if you have a high frequency of events (keep
> > > > > > in mind, throughput doesn't matter, only contention on sample
> > > > > > reservation matters), you might want to use an array of BPF
> > > > > > ringbufs to scale throughput. You can do 1 ringbuf per each CPU
> > > > > > for ultimate performance at the expense of memory usage (that's
> > > > > > perf ring buffer setup), but BPF ringbuf is flexible enough to
> > > > > > allow any topology that makes sense for you use case, from 1 shared
> > ringbuf across all CPUs, to anything in between.
> > > > > > >
> > > > > > >

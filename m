Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E677129993A
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 23:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbgJZWBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 18:01:49 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42889 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391626AbgJZWBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 18:01:49 -0400
Received: by mail-yb1-f196.google.com with SMTP id a12so8970566ybg.9
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UqCwDawJKMNmz/OT/jbMjwOCqveZiWYY8gjIMa6+8UE=;
        b=dHxPxAVXqZaNOTCmgaQEv7UVLyJcHXZoiZchBHpNgDuFzj8eopllCeFN0zyzM/Hske
         1/9VDxiq3QHx6/tWk/tk0nGSUbnfAUEAQ8c1epk7hVS0HogwZKF9/wnvQ/IGiSXnX5VQ
         POJ8j+V6SGUDVL58mIjMf4IHt48t9FJqi/tzNUXUbzQwHzY8AF09Sg5K8e9CWO7VyVFJ
         syS198rduGubVqLdWQyRWsh2ZbV5b/P00keFi7DXnDh4AGLVDpxsgM893jdLORqUCldh
         cbF+TXRek35/RRyhqGaYF4GmujIeZAdqKfMpxX4UxfwswHhhYPXSG5+cL8M/AVuTsxYy
         5H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UqCwDawJKMNmz/OT/jbMjwOCqveZiWYY8gjIMa6+8UE=;
        b=WDEB18lzRysIB1+LvkOeFT1ym8DfCFlXcdbq8HccjzdRVHvfTCFqgO7n9Z9tpVZKEk
         KJUokRj+AOJM/zMDDFArBWWM58F5NaeyJit265y1iPHTcKWshlUC6TbVmWz0oYkbckeL
         SVbaZtqX9Mv2SypWowS46VoOoJZJPBabp7CcV+oGQq6l+0AF5lgioHwb/bkHwuFJ62LI
         EtHiyx6SvLs94/eb9ekF7rsOnI9OKuHtHat6oDKP5iTeNeS53OiODpnGMJKWOj/i24AU
         Iln58H+aBttSEEmFZEyEfMdbeU86debJ20M7lgnI3wduX6tzT0pv8tl3SnLyMZ09jpAU
         E52g==
X-Gm-Message-State: AOAM5329/hIJ3oUzOnm1fEQ33IOAQ+uNA9Ejv2zMgmHZ20P5gLEvGyqE
        8jFTCE7rTd+xymX67GAkytHuUrkgmth2afH0ezc=
X-Google-Smtp-Source: ABdhPJyt8Ezlxsatv7bZHfSx5k4h5qXebIJ7MKtLWKBUTlZEY22BYFfQ+R1iU/I8UEYAzMeQ7D+MYXvZO1YdhC3pitQ=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr27058035ybe.403.1603749705755;
 Mon, 26 Oct 2020 15:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
 <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
 <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <CAEf4BzZj8z5YWHQkYBjBuQ2LUwvodt7tz_9=GZzZ6hcW3zkj5g@mail.gmail.com>
 <HE1PR83MB0220B3D0413E997D1A33FA52FB770@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <VI1PR8303MB00808A980F003A9F403E413EFB190@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
In-Reply-To: <VI1PR8303MB00808A980F003A9F403E413EFB190@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 15:01:34 -0700
Message-ID: <CAEf4BzYOrZ4swcobfjJ3Or5Pp--4dNkv8JwhJXjQfCPao-Xpvw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 10:10 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> Hello Andrii and list
>
> I've now had chance to properly investigate the perf ring buffer corrupti=
on bug.  Essentially (as suspected), the size parameter that is specified a=
s a __u64 in bpf_helper_defs.h, is truncated into a __u16 inside the struct=
 perf_event_header size parameter ($KERNELSRC/include/uapi/linux/perf_event=
.h and /usr/include/linux/perf_event.h).
>
> Changing the size parameter in perf_event_header (both locations) to a __=
u32 (or __u64 if you prefer) fixes my issue of sending more than 64KB of da=
ta in a single perf sample, but I'm not convinced that this is a good or wo=
rkable solution.

Right, this will break ABI compatibility with all the applications,
unfortunately.

>
> As I, and probably others, are more likely to tend towards much smaller, =
fragmented packets, I suggest (having spoken to KP Singh) that the fix shou=
ld probably be in the verifier - to ensure the size is <0xffff - 8 (sizeof(=
struct perf_event_header) I guess) - and also in bpf_helper_defs.h to raise=
 a clang warning/error, as well as in the bpf_helpers man page.
>
> The bpf_helper_defs.h and man page updates are trivial, but I can't work =
out where in verifier.c the check should go.  It feels like it should be in=
 check_helper_call() but I can't see any other similar checks in there.  I =
suspect that the better fix would be to create another ARG_CONST_SIZE type,=
 such as ARG_CONST_SIZE_PERF_SAMPLE, that can be explicitly checked rather =
than adding ad hoc size checks.
>
> As this causes corruption inside the perf ring buffer as samples overlap,=
 and the reported sample size is questionable, please can I ask for some he=
lp in fixing this?

I don't think it's possible to enforce this statically in verifier in
all cases. The size of the sample can be dynamically determined, so
BPF verifier can't do much about that. It seems like the proper
solution is to do the check in bpf_perf_event_output() BPF helper
itself. Returning -E2BIG is an appropriate behavior here, rather than
corrupting data. __u64 if helper definition is fine as well, because
that's the size of BPF registers that are used to pass arguments to
helpers.

>
> Thanks
>
> Kevin Sheldrake
>
> PS I will get around to the clang/LLVM jump offset warning soon I promise=
.
>
>
>
> > -----Original Message-----
> > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On Behalf
> > Of Kevin Sheldrake
> > Sent: 24 July 2020 10:40
> > To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: bpf@vger.kernel.org
> > Subject: RE: [EXTERNAL] Re: Maximum size of record over perf ring buffe=
r?
> >
> > Hello Andrii
> >
> > Thank you for taking a look at this.  While the size is reported correc=
tly to the
> > consumer (bar padding, etc), the actual offsets between adjacent pointe=
rs
> > appears to either have been cast to a u16 or otherwise masked with 0xFF=
FF,
> > causing what I believe to be overlapping samples and the opportunity fo=
r
> > sample corruption in the overlapped regions.
> >
> > Thanks again
> >
> > Kev
> >
> >
> > -----Original Message-----
> > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Sent: 23 July 2020 20:05
> > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > Cc: bpf@vger.kernel.org
> > Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buffe=
r?
> >
> > On Mon, Jul 20, 2020 at 4:39 AM Kevin Sheldrake
> > <Kevin.Sheldrake@microsoft.com> wrote:
> > >
> > > Hello
> > >
> > > Thank you for your response; I hope you don't mind me top-posting.  I=
've
> > put together a POC that demonstrates my results.  Edit the size of the =
data
> > char array in event_defs.h to change the behaviour.
> > >
> > >
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > > ub.com%2Fmicrosoft%2FOMS-Auditd-Plugin%2Ftree%2FMSTIC-
> > Research%2Febpf_
> > >
> > perf_output_poc&amp;data=3D02%7C01%7CKevin.Sheldrake%40microsoft.co
> > m%7C8
> > >
> > bd9fb551cd4454b87a608d82f3b57c0%7C72f988bf86f141af91ab2d7cd011db47
> > %7C1
> > >
> > %7C0%7C637311279211606351&amp;sdata=3DjMMpfi%2Bd%2B7jZzMT905xJ61
> > 34cDJd5u
> > > MNSu9RCdx4M6s%3D&amp;reserved=3D0
> >
> > I haven't run your program, but I can certainly reproduce this using
> > bench_perfbuf in selftests. It does seem like something is silently cor=
rupted,
> > because the size reported by perf is correct (plus/minus few bytes, pro=
bably
> > rounding up to 8 bytes), but the contents is not correct. I have no ide=
a why
> > that's happening, maybe someone more familiar with the perf subsystem
> > can take a look.
> >
> > >
> > > Unfortunately, our project aims to run on older kernels than 5.8 so t=
he bpf
> > ring buffer won't work for us.
> > >
> > > Thanks again
> > >
> > > Kevin Sheldrake
> > >
> > >
> > > -----Original Message-----
> > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On
> > Behalf
> > > Of Andrii Nakryiko
> > > Sent: 20 July 2020 05:35
> > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > Cc: bpf@vger.kernel.org
> > > Subject: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
> > >
> > > On Fri, Jul 17, 2020 at 7:24 AM Kevin Sheldrake
> > <Kevin.Sheldrake@microsoft.com> wrote:
> > > >
> > > > Hello
> > > >
> > > > I'm building a tool using EBPF/libbpf/C and I've run into an issue =
that I'd
> > like to ask about.  I haven't managed to find documentation for the
> > maximum size of a record that can be sent over the perf ring buffer, bu=
t
> > experimentation (on kernel 5.3 (x64) with latest libbpf from github) su=
ggests
> > it is just short of 64KB.  Please could someone confirm if that's the c=
ase or
> > not?  My experiments suggest that sending a record that is greater than=
 64KB
> > results in the size reported in the callback being correct but the reco=
rds
> > overlapping, causing corruption if they are not serviced as quickly as =
they
> > arrive.  Setting the record to exactly 64KB results in no records being=
 received
> > at all.
> > > >
> > > > For reference, I'm using perf_buffer__new() and perf_buffer__poll()=
 on
> > the userland side; and bpf_perf_event_output(ctx, &event_map,
> > BPF_F_CURRENT_CPU, event, sizeof(event_s)) on the EBPF side.
> > > >
> > > > Additionally, is there a better architecture for sending large volu=
mes of
> > data (>64KB) back from the EBPF program to userland, such as a differen=
t
> > ring buffer, a map, some kind of shared mmaped segment, etc, other than
> > simply fragmenting the data?  Please excuse my naivety as I'm relativel=
y new
> > to the world of EBPF.
> > > >
> > >
> > > I'm not aware of any such limitations for perf ring buffer and I have=
n't had a
> > chance to validate this. It would be great if you can provide a small r=
epro so
> > that someone can take a deeper look, it does sound like a bug, if you r=
eally
> > get clobbered data. It might be actually how you set up perfbuf, AFAIK,=
 it has
> > a mode where it will override the data, if it's not consumed quickly en=
ough,
> > but you need to consciously enable that mode.
> > >
> > > But apart from that, shameless plug here, you can try the new BPF rin=
g
> > buffer ([0]), available in 5.8+ kernels. It will allow you to avoid ext=
ra copy of
> > data you get with bpf_perf_event_output(), if you use BPF ringbuf's
> > bpf_ringbuf_reserve() + bpf_ringbuf_commit() API. It also has
> > bpf_ringbuf_output() API, which is logically  equivalent to
> > bpf_perf_event_output(). And it has a very high limit on sample size, u=
p to
> > 512MB per sample.
> > >
> > > Keep in mind, BPF ringbuf is MPSC design and if you use just one BPF
> > ringbuf across all CPUs, you might run into some contention across mult=
iple
> > CPU. It is acceptable in a lot of applications I was targeting, but if =
you have a
> > high frequency of events (keep in mind, throughput doesn't matter, only
> > contention on sample reservation matters), you might want to use an arr=
ay
> > of BPF ringbufs to scale throughput. You can do 1 ringbuf per each CPU =
for
> > ultimate performance at the expense of memory usage (that's perf ring
> > buffer setup), but BPF ringbuf is flexible enough to allow any topology=
 that
> > makes sense for you use case, from 1 shared ringbuf across all CPUs, to
> > anything in between.
> > >
> > >

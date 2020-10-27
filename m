Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF9329A36A
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 04:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440854AbgJ0Dnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 23:43:49 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42735 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440738AbgJ0Dns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 23:43:48 -0400
Received: by mail-yb1-f193.google.com with SMTP id a12so51822ybg.9
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 20:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gnk9F36cXzRilq+x7+lq5G+osWXokJug9K85xhPKbH0=;
        b=jaTIluj+HSKWRbyqSNeJRnVSctea08CmvrQdvZrSK/Cr86fXQmCF+4WXWSjWP0oGlY
         ZcEfcuFIGxg6zkNglyIiW5mBIPmpD9Dh4xONNg522EAHCNUomfoHFsqkVERsH9Jfp/Ty
         BqiwkC6SrxAOhyXyOaQlPmXol9aql88EF67SFA/oVx5J01Nu49rvBmtlIRXUR8lu2Egb
         sZ+BUCSTDE/KrCdFgFbrHeJK7LaDoLi7DuRjYiRZnNwia9GHD1jyy4k2RLL2TKL5mtvX
         YCsYjJRnZAbmqRsseaG05iWar5Sv+SLeyyrWrKNAb7PbF/ohpeC2Vc5e0WD2+AYz082l
         ErJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gnk9F36cXzRilq+x7+lq5G+osWXokJug9K85xhPKbH0=;
        b=fR9zEyH1iZ0TPcYRalKlq2wY/Q2AhbvGz5VqYuUN3dO+NGN691aAnhxA9oLqgRowk3
         MlzkNYxVoAqJt/Pl1w7wDegacEr89U0LJS5VgC7wvYm5NdgCLiLf7kusZOl78yFBtuHi
         eFG6xot8xI7bCM9K7vF0hHSS8HIM9kjQ27lsL3C0+0gn5pHmfLlF+qJpPF9LUNc0S0YC
         hLlBLjDClq6uzVzN9igYzczG3NznUHPNST+sCnd0B2Tr2XONmmJTG0kk1L+XIQyE/KSa
         CAPPNM8eTFe5QDwes/or+kd2Uj4q1bINP1El35P4KtaI8/5JWZhBKttwg0xhlz1J7MWB
         Q14g==
X-Gm-Message-State: AOAM531uzaHBzeRoUYXFZWhBp8hkDJpPZA4zURZo86zbc2n4ZFC8aljX
        Svzr+S1kT+XYJff+Rs6uVGF4mRNBgtibnL3knq8HCttsVWc=
X-Google-Smtp-Source: ABdhPJz2lfgoqkA1Nwp+6ecpsw991ohF3bASs6i/prpb3uf4OdlSA08l/ChWRcMHCvVSFye3huhH+naqG0ccxH72/Wo=
X-Received: by 2002:a25:25c2:: with SMTP id l185mr382303ybl.230.1603770225296;
 Mon, 26 Oct 2020 20:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
 <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
 <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <CAEf4BzZj8z5YWHQkYBjBuQ2LUwvodt7tz_9=GZzZ6hcW3zkj5g@mail.gmail.com>
 <HE1PR83MB0220B3D0413E997D1A33FA52FB770@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <VI1PR8303MB00808A980F003A9F403E413EFB190@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CAEf4BzYOrZ4swcobfjJ3Or5Pp--4dNkv8JwhJXjQfCPao-Xpvw@mail.gmail.com> <CACYkzJ4DU2AkMqvfZ0JDBGE4XPep2Lu2mo6muy1zqk-Y7esh5w@mail.gmail.com>
In-Reply-To: <CACYkzJ4DU2AkMqvfZ0JDBGE4XPep2Lu2mo6muy1zqk-Y7esh5w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 20:43:34 -0700
Message-ID: <CAEf4BzazZQ_Y5S9kG=JV12M7gH0XoTkMViWncOqs6Q+qGNmvdg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
To:     KP Singh <kpsingh@chromium.org>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 6:07 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On Mon, Oct 26, 2020 at 11:01 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 26, 2020 at 10:10 AM Kevin Sheldrake
> > <Kevin.Sheldrake@microsoft.com> wrote:
> > >
> > > Hello Andrii and list
> > >
> > > I've now had chance to properly investigate the perf ring buffer corr=
uption bug.  Essentially (as suspected), the size parameter that is specifi=
ed as a __u64 in bpf_helper_defs.h, is truncated into a __u16 inside the st=
ruct perf_event_header size parameter ($KERNELSRC/include/uapi/linux/perf_e=
vent.h and /usr/include/linux/perf_event.h).
> > >
> > > Changing the size parameter in perf_event_header (both locations) to =
a __u32 (or __u64 if you prefer) fixes my issue of sending more than 64KB o=
f data in a single perf sample, but I'm not convinced that this is a good o=
r workable solution.
> >
> > Right, this will break ABI compatibility with all the applications,
> > unfortunately.
> >
> > >
> > > As I, and probably others, are more likely to tend towards much small=
er, fragmented packets, I suggest (having spoken to KP Singh) that the fix =
should probably be in the verifier - to ensure the size is <0xffff - 8 (siz=
eof(struct perf_event_header) I guess) - and also in bpf_helper_defs.h to r=
aise a clang warning/error, as well as in the bpf_helpers man page.
> > >
> > > The bpf_helper_defs.h and man page updates are trivial, but I can't w=
ork out where in verifier.c the check should go.  It feels like it should b=
e in check_helper_call() but I can't see any other similar checks in there.=
  I suspect that the better fix would be to create another ARG_CONST_SIZE t=
ype, such as ARG_CONST_SIZE_PERF_SAMPLE, that can be explicitly checked rat=
her than adding ad hoc size checks.
> > >
> > > As this causes corruption inside the perf ring buffer as samples over=
lap, and the reported sample size is questionable, please can I ask for som=
e help in fixing this?
> >
> > I don't think it's possible to enforce this statically in verifier in
> > all cases. The size of the sample can be dynamically determined, so
>
> Are you sure it cannot be done in the verifier and that we can set the
> size of the sample dynamically?
>
> The size argument is of the type ARG_CONST_SIZE_OR_ZERO:
>
> static const struct bpf_func_proto bpf_perf_event_output_proto =3D {
>    .func =3D bpf_perf_event_output,
>    .gpl_only =3D true,
>    .ret_type =3D RET_INTEGER,
>    .arg1_type =3D ARG_PTR_TO_CTX,
>    .arg2_type =3D ARG_CONST_MAP_PTR,
>    .arg3_type =3D ARG_ANYTHING,
>    .arg4_type =3D ARG_PTR_TO_MEM,
>    .arg5_type =3D ARG_CONST_SIZE_OR_ZERO,
> };
>
> and we do similar checks in the verifier with the BPF_MAX_VAR_SIZ:
>
> if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
>    verbose(env, "R%d unbounded memory access, use 'var &=3D const' or
> 'if (var < const)'\n",
>       regno);
>    return -EACCES;
> }

You are right, of course, my bad. Verifier might not know the exact
value, but it enforces the upper bound. So in this case we can
additionally enforce extra upper bound for bpf_perf_event_output().
Though, given this will require kernel upgrade, I'd just stick to BPF
ringbuf at that point ;)

>
> it's just that bpf_perf_event_output expects the size to be even
> smaller than 32 bits (i.e. 16 bits).
>
> > BPF verifier can't do much about that. It seems like the proper
> > solution is to do the check in bpf_perf_event_output() BPF helper
> > itself. Returning -E2BIG is an appropriate behavior here, rather than
>
> This could be a solution (and maybe better than the verifier check).
>
> But I do think perf needs to have the check instead of bpf_perf_event_out=
put:

Yeah, of course, perf subsystem itself shouldn't allow data
corruption. My point was to do it as a runtime check, rather than
enforce at verification time. But both would work fine.

>
> The size in the perf always seems to be u32 except the perf_event_header
> (I assume this is to save some space on the ring buffer)

Probably saving space, yeah. Though it's wasting 3 lower bits because
all sizes seem to be multiple of 8 always. So could the real limit
could be 8 * 64K =3D 512KB, easily. But it's a bit late now.

>
> struct perf_raw_frag {
>      union {
>          struct perf_raw_frag *next;
>          unsigned long pad;
>      };
>     perf_copy_f copy;
>     void *data;
>     u32 size;
> } __packed;
>
> struct perf_raw_record {
>    struct perf_raw_frag frag;
>     u32 size;
> };
>
> Maybe we can just add the check to perf_event_output instead?
>
> - KP
>
> > corrupting data. __u64 if helper definition is fine as well, because
> > that's the size of BPF registers that are used to pass arguments to
> > helpers.
> >
> > >
> > > Thanks
> > >
> > > Kevin Sheldrake
> > >
> > > PS I will get around to the clang/LLVM jump offset warning soon I pro=
mise.
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On Beha=
lf
> > > > Of Kevin Sheldrake
> > > > Sent: 24 July 2020 10:40
> > > > To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: bpf@vger.kernel.org
> > > > Subject: RE: [EXTERNAL] Re: Maximum size of record over perf ring b=
uffer?
> > > >
> > > > Hello Andrii
> > > >
> > > > Thank you for taking a look at this.  While the size is reported co=
rrectly to the
> > > > consumer (bar padding, etc), the actual offsets between adjacent po=
inters
> > > > appears to either have been cast to a u16 or otherwise masked with =
0xFFFF,
> > > > causing what I believe to be overlapping samples and the opportunit=
y for
> > > > sample corruption in the overlapped regions.
> > > >
> > > > Thanks again
> > > >
> > > > Kev
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Sent: 23 July 2020 20:05
> > > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > > Cc: bpf@vger.kernel.org
> > > > Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring b=
uffer?
> > > >
> > > > On Mon, Jul 20, 2020 at 4:39 AM Kevin Sheldrake
> > > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > > >
> > > > > Hello
> > > > >
> > > > > Thank you for your response; I hope you don't mind me top-posting=
.  I've
> > > > put together a POC that demonstrates my results.  Edit the size of =
the data
> > > > char array in event_defs.h to change the behaviour.
> > > > >
> > > > >
> > > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgith
> > > > > ub.com%2Fmicrosoft%2FOMS-Auditd-Plugin%2Ftree%2FMSTIC-
> > > > Research%2Febpf_
> > > > >
> > > > perf_output_poc&amp;data=3D02%7C01%7CKevin.Sheldrake%40microsoft.co
> > > > m%7C8
> > > > >
> > > > bd9fb551cd4454b87a608d82f3b57c0%7C72f988bf86f141af91ab2d7cd011db47
> > > > %7C1
> > > > >
> > > > %7C0%7C637311279211606351&amp;sdata=3DjMMpfi%2Bd%2B7jZzMT905xJ61
> > > > 34cDJd5u
> > > > > MNSu9RCdx4M6s%3D&amp;reserved=3D0
> > > >
> > > > I haven't run your program, but I can certainly reproduce this usin=
g
> > > > bench_perfbuf in selftests. It does seem like something is silently=
 corrupted,
> > > > because the size reported by perf is correct (plus/minus few bytes,=
 probably
> > > > rounding up to 8 bytes), but the contents is not correct. I have no=
 idea why
> > > > that's happening, maybe someone more familiar with the perf subsyst=
em
> > > > can take a look.
> > > >
> > > > >
> > > > > Unfortunately, our project aims to run on older kernels than 5.8 =
so the bpf
> > > > ring buffer won't work for us.
> > > > >
> > > > > Thanks again
> > > > >
> > > > > Kevin Sheldrake
> > > > >
> > > > >
> > > > > -----Original Message-----
> > > > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On
> > > > Behalf
> > > > > Of Andrii Nakryiko
> > > > > Sent: 20 July 2020 05:35
> > > > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > > > Cc: bpf@vger.kernel.org
> > > > > Subject: [EXTERNAL] Re: Maximum size of record over perf ring buf=
fer?
> > > > >
> > > > > On Fri, Jul 17, 2020 at 7:24 AM Kevin Sheldrake
> > > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > > > >
> > > > > > Hello
> > > > > >
> > > > > > I'm building a tool using EBPF/libbpf/C and I've run into an is=
sue that I'd
> > > > like to ask about.  I haven't managed to find documentation for the
> > > > maximum size of a record that can be sent over the perf ring buffer=
, but
> > > > experimentation (on kernel 5.3 (x64) with latest libbpf from github=
) suggests
> > > > it is just short of 64KB.  Please could someone confirm if that's t=
he case or
> > > > not?  My experiments suggest that sending a record that is greater =
than 64KB
> > > > results in the size reported in the callback being correct but the =
records
> > > > overlapping, causing corruption if they are not serviced as quickly=
 as they
> > > > arrive.  Setting the record to exactly 64KB results in no records b=
eing received
> > > > at all.
> > > > > >
> > > > > > For reference, I'm using perf_buffer__new() and perf_buffer__po=
ll() on
> > > > the userland side; and bpf_perf_event_output(ctx, &event_map,
> > > > BPF_F_CURRENT_CPU, event, sizeof(event_s)) on the EBPF side.
> > > > > >
> > > > > > Additionally, is there a better architecture for sending large =
volumes of
> > > > data (>64KB) back from the EBPF program to userland, such as a diff=
erent
> > > > ring buffer, a map, some kind of shared mmaped segment, etc, other =
than
> > > > simply fragmenting the data?  Please excuse my naivety as I'm relat=
ively new
> > > > to the world of EBPF.
> > > > > >
> > > > >
> > > > > I'm not aware of any such limitations for perf ring buffer and I =
haven't had a
> > > > chance to validate this. It would be great if you can provide a sma=
ll repro so
> > > > that someone can take a deeper look, it does sound like a bug, if y=
ou really
> > > > get clobbered data. It might be actually how you set up perfbuf, AF=
AIK, it has
> > > > a mode where it will override the data, if it's not consumed quickl=
y enough,
> > > > but you need to consciously enable that mode.
> > > > >
> > > > > But apart from that, shameless plug here, you can try the new BPF=
 ring
> > > > buffer ([0]), available in 5.8+ kernels. It will allow you to avoid=
 extra copy of
> > > > data you get with bpf_perf_event_output(), if you use BPF ringbuf's
> > > > bpf_ringbuf_reserve() + bpf_ringbuf_commit() API. It also has
> > > > bpf_ringbuf_output() API, which is logically  equivalent to
> > > > bpf_perf_event_output(). And it has a very high limit on sample siz=
e, up to
> > > > 512MB per sample.
> > > > >
> > > > > Keep in mind, BPF ringbuf is MPSC design and if you use just one =
BPF
> > > > ringbuf across all CPUs, you might run into some contention across =
multiple
> > > > CPU. It is acceptable in a lot of applications I was targeting, but=
 if you have a
> > > > high frequency of events (keep in mind, throughput doesn't matter, =
only
> > > > contention on sample reservation matters), you might want to use an=
 array
> > > > of BPF ringbufs to scale throughput. You can do 1 ringbuf per each =
CPU for
> > > > ultimate performance at the expense of memory usage (that's perf ri=
ng
> > > > buffer setup), but BPF ringbuf is flexible enough to allow any topo=
logy that
> > > > makes sense for you use case, from 1 shared ringbuf across all CPUs=
, to
> > > > anything in between.
> > > > >
> > > > >

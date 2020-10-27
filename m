Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94B829A208
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 02:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410119AbgJ0BHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 21:07:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46922 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409211AbgJ0BHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 21:07:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id v6so15010436lfa.13
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cVg+J7CmwRV+4Z6r4qkgseO7XTLkFM3+GmFNOFG8M5c=;
        b=mt7Nir4DGQkMfgc3gH+iJagQHbiKKLPKnlgi0RzNZpwDt/6RY7peDFYL9nV2gz4SRX
         EFLs8HxqFZ+C1Osq4DiWmQdz0VgHuNx9BZxk3pa63MvyfH323hKthQqSBILKVB3hg7YS
         YDeuis4DLLTZ7uj7bx67XaFJxd2hBaQ2sMuQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cVg+J7CmwRV+4Z6r4qkgseO7XTLkFM3+GmFNOFG8M5c=;
        b=JIt/ElsbHH5Fnbiuoi2VoBVKNgK8EWgAbPHZDpW8w7ms0ehJaBDuMMYGdC9/wfMgnV
         ZbAX6JaIeGQkmXHJRJQIBX7SMgIoNpE9xk7dpnPx8+N0+izPZX+godbWYVA1PQzgKhWt
         GxaamVLCR6BREtoWWSa/0HI8tvfSEammh1LrlqWHAJJUKZCj8hKLLDeOhkJc+awXT02E
         QP27DgmDa3+2hL5bQF9mxCON5bfDrRnDY5HQPf6qEo86eYqXaIWp2eKS+C2oL4OKdWCA
         zrv+x+v62DSH+vrDC2JPv2mMPrlX5ipvRhgp2kCArUtxTLr6dPvcG459JlWCWh01Yasy
         5mfg==
X-Gm-Message-State: AOAM532bx3GVAoWyv6imBUtU5u1VOcQD9rO6TJS5rOajMcUqyM5+F1zu
        jzkGb2tlbXOEExMcSt8OATc5IYZy/xU8GRXcNR760A==
X-Google-Smtp-Source: ABdhPJw8/UOr9Ns8Q7+RyAPUAIMSyKZezbJ/ZE/lVtgc5Yzm9Hupjd1aCOhLLRVjnowTWrEnp89YcNpC9H6Ej/5qCbo=
X-Received: by 2002:a19:641b:: with SMTP id y27mr5856527lfb.146.1603760856936;
 Mon, 26 Oct 2020 18:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
 <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
 <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <CAEf4BzZj8z5YWHQkYBjBuQ2LUwvodt7tz_9=GZzZ6hcW3zkj5g@mail.gmail.com>
 <HE1PR83MB0220B3D0413E997D1A33FA52FB770@HE1PR83MB0220.EURPRD83.prod.outlook.com>
 <VI1PR8303MB00808A980F003A9F403E413EFB190@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CAEf4BzYOrZ4swcobfjJ3Or5Pp--4dNkv8JwhJXjQfCPao-Xpvw@mail.gmail.com>
In-Reply-To: <CAEf4BzYOrZ4swcobfjJ3Or5Pp--4dNkv8JwhJXjQfCPao-Xpvw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 27 Oct 2020 02:07:26 +0100
Message-ID: <CACYkzJ4DU2AkMqvfZ0JDBGE4XPep2Lu2mo6muy1zqk-Y7esh5w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 11:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 26, 2020 at 10:10 AM Kevin Sheldrake
> <Kevin.Sheldrake@microsoft.com> wrote:
> >
> > Hello Andrii and list
> >
> > I've now had chance to properly investigate the perf ring buffer corrup=
tion bug.  Essentially (as suspected), the size parameter that is specified=
 as a __u64 in bpf_helper_defs.h, is truncated into a __u16 inside the stru=
ct perf_event_header size parameter ($KERNELSRC/include/uapi/linux/perf_eve=
nt.h and /usr/include/linux/perf_event.h).
> >
> > Changing the size parameter in perf_event_header (both locations) to a =
__u32 (or __u64 if you prefer) fixes my issue of sending more than 64KB of =
data in a single perf sample, but I'm not convinced that this is a good or =
workable solution.
>
> Right, this will break ABI compatibility with all the applications,
> unfortunately.
>
> >
> > As I, and probably others, are more likely to tend towards much smaller=
, fragmented packets, I suggest (having spoken to KP Singh) that the fix sh=
ould probably be in the verifier - to ensure the size is <0xffff - 8 (sizeo=
f(struct perf_event_header) I guess) - and also in bpf_helper_defs.h to rai=
se a clang warning/error, as well as in the bpf_helpers man page.
> >
> > The bpf_helper_defs.h and man page updates are trivial, but I can't wor=
k out where in verifier.c the check should go.  It feels like it should be =
in check_helper_call() but I can't see any other similar checks in there.  =
I suspect that the better fix would be to create another ARG_CONST_SIZE typ=
e, such as ARG_CONST_SIZE_PERF_SAMPLE, that can be explicitly checked rathe=
r than adding ad hoc size checks.
> >
> > As this causes corruption inside the perf ring buffer as samples overla=
p, and the reported sample size is questionable, please can I ask for some =
help in fixing this?
>
> I don't think it's possible to enforce this statically in verifier in
> all cases. The size of the sample can be dynamically determined, so

Are you sure it cannot be done in the verifier and that we can set the
size of the sample dynamically?

The size argument is of the type ARG_CONST_SIZE_OR_ZERO:

static const struct bpf_func_proto bpf_perf_event_output_proto =3D {
   .func =3D bpf_perf_event_output,
   .gpl_only =3D true,
   .ret_type =3D RET_INTEGER,
   .arg1_type =3D ARG_PTR_TO_CTX,
   .arg2_type =3D ARG_CONST_MAP_PTR,
   .arg3_type =3D ARG_ANYTHING,
   .arg4_type =3D ARG_PTR_TO_MEM,
   .arg5_type =3D ARG_CONST_SIZE_OR_ZERO,
};

and we do similar checks in the verifier with the BPF_MAX_VAR_SIZ:

if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
   verbose(env, "R%d unbounded memory access, use 'var &=3D const' or
'if (var < const)'\n",
      regno);
   return -EACCES;
}

it's just that bpf_perf_event_output expects the size to be even
smaller than 32 bits (i.e. 16 bits).

> BPF verifier can't do much about that. It seems like the proper
> solution is to do the check in bpf_perf_event_output() BPF helper
> itself. Returning -E2BIG is an appropriate behavior here, rather than

This could be a solution (and maybe better than the verifier check).

But I do think perf needs to have the check instead of bpf_perf_event_outpu=
t:

The size in the perf always seems to be u32 except the perf_event_header
(I assume this is to save some space on the ring buffer)

struct perf_raw_frag {
     union {
         struct perf_raw_frag *next;
         unsigned long pad;
     };
    perf_copy_f copy;
    void *data;
    u32 size;
} __packed;

struct perf_raw_record {
   struct perf_raw_frag frag;
    u32 size;
};

Maybe we can just add the check to perf_event_output instead?

- KP

> corrupting data. __u64 if helper definition is fine as well, because
> that's the size of BPF registers that are used to pass arguments to
> helpers.
>
> >
> > Thanks
> >
> > Kevin Sheldrake
> >
> > PS I will get around to the clang/LLVM jump offset warning soon I promi=
se.
> >
> >
> >
> > > -----Original Message-----
> > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On Behalf
> > > Of Kevin Sheldrake
> > > Sent: 24 July 2020 10:40
> > > To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: bpf@vger.kernel.org
> > > Subject: RE: [EXTERNAL] Re: Maximum size of record over perf ring buf=
fer?
> > >
> > > Hello Andrii
> > >
> > > Thank you for taking a look at this.  While the size is reported corr=
ectly to the
> > > consumer (bar padding, etc), the actual offsets between adjacent poin=
ters
> > > appears to either have been cast to a u16 or otherwise masked with 0x=
FFFF,
> > > causing what I believe to be overlapping samples and the opportunity =
for
> > > sample corruption in the overlapped regions.
> > >
> > > Thanks again
> > >
> > > Kev
> > >
> > >
> > > -----Original Message-----
> > > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Sent: 23 July 2020 20:05
> > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > Cc: bpf@vger.kernel.org
> > > Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buf=
fer?
> > >
> > > On Mon, Jul 20, 2020 at 4:39 AM Kevin Sheldrake
> > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > >
> > > > Hello
> > > >
> > > > Thank you for your response; I hope you don't mind me top-posting. =
 I've
> > > put together a POC that demonstrates my results.  Edit the size of th=
e data
> > > char array in event_defs.h to change the behaviour.
> > > >
> > > >
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ith
> > > > ub.com%2Fmicrosoft%2FOMS-Auditd-Plugin%2Ftree%2FMSTIC-
> > > Research%2Febpf_
> > > >
> > > perf_output_poc&amp;data=3D02%7C01%7CKevin.Sheldrake%40microsoft.co
> > > m%7C8
> > > >
> > > bd9fb551cd4454b87a608d82f3b57c0%7C72f988bf86f141af91ab2d7cd011db47
> > > %7C1
> > > >
> > > %7C0%7C637311279211606351&amp;sdata=3DjMMpfi%2Bd%2B7jZzMT905xJ61
> > > 34cDJd5u
> > > > MNSu9RCdx4M6s%3D&amp;reserved=3D0
> > >
> > > I haven't run your program, but I can certainly reproduce this using
> > > bench_perfbuf in selftests. It does seem like something is silently c=
orrupted,
> > > because the size reported by perf is correct (plus/minus few bytes, p=
robably
> > > rounding up to 8 bytes), but the contents is not correct. I have no i=
dea why
> > > that's happening, maybe someone more familiar with the perf subsystem
> > > can take a look.
> > >
> > > >
> > > > Unfortunately, our project aims to run on older kernels than 5.8 so=
 the bpf
> > > ring buffer won't work for us.
> > > >
> > > > Thanks again
> > > >
> > > > Kevin Sheldrake
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On
> > > Behalf
> > > > Of Andrii Nakryiko
> > > > Sent: 20 July 2020 05:35
> > > > To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > > > Cc: bpf@vger.kernel.org
> > > > Subject: [EXTERNAL] Re: Maximum size of record over perf ring buffe=
r?
> > > >
> > > > On Fri, Jul 17, 2020 at 7:24 AM Kevin Sheldrake
> > > <Kevin.Sheldrake@microsoft.com> wrote:
> > > > >
> > > > > Hello
> > > > >
> > > > > I'm building a tool using EBPF/libbpf/C and I've run into an issu=
e that I'd
> > > like to ask about.  I haven't managed to find documentation for the
> > > maximum size of a record that can be sent over the perf ring buffer, =
but
> > > experimentation (on kernel 5.3 (x64) with latest libbpf from github) =
suggests
> > > it is just short of 64KB.  Please could someone confirm if that's the=
 case or
> > > not?  My experiments suggest that sending a record that is greater th=
an 64KB
> > > results in the size reported in the callback being correct but the re=
cords
> > > overlapping, causing corruption if they are not serviced as quickly a=
s they
> > > arrive.  Setting the record to exactly 64KB results in no records bei=
ng received
> > > at all.
> > > > >
> > > > > For reference, I'm using perf_buffer__new() and perf_buffer__poll=
() on
> > > the userland side; and bpf_perf_event_output(ctx, &event_map,
> > > BPF_F_CURRENT_CPU, event, sizeof(event_s)) on the EBPF side.
> > > > >
> > > > > Additionally, is there a better architecture for sending large vo=
lumes of
> > > data (>64KB) back from the EBPF program to userland, such as a differ=
ent
> > > ring buffer, a map, some kind of shared mmaped segment, etc, other th=
an
> > > simply fragmenting the data?  Please excuse my naivety as I'm relativ=
ely new
> > > to the world of EBPF.
> > > > >
> > > >
> > > > I'm not aware of any such limitations for perf ring buffer and I ha=
ven't had a
> > > chance to validate this. It would be great if you can provide a small=
 repro so
> > > that someone can take a deeper look, it does sound like a bug, if you=
 really
> > > get clobbered data. It might be actually how you set up perfbuf, AFAI=
K, it has
> > > a mode where it will override the data, if it's not consumed quickly =
enough,
> > > but you need to consciously enable that mode.
> > > >
> > > > But apart from that, shameless plug here, you can try the new BPF r=
ing
> > > buffer ([0]), available in 5.8+ kernels. It will allow you to avoid e=
xtra copy of
> > > data you get with bpf_perf_event_output(), if you use BPF ringbuf's
> > > bpf_ringbuf_reserve() + bpf_ringbuf_commit() API. It also has
> > > bpf_ringbuf_output() API, which is logically  equivalent to
> > > bpf_perf_event_output(). And it has a very high limit on sample size,=
 up to
> > > 512MB per sample.
> > > >
> > > > Keep in mind, BPF ringbuf is MPSC design and if you use just one BP=
F
> > > ringbuf across all CPUs, you might run into some contention across mu=
ltiple
> > > CPU. It is acceptable in a lot of applications I was targeting, but i=
f you have a
> > > high frequency of events (keep in mind, throughput doesn't matter, on=
ly
> > > contention on sample reservation matters), you might want to use an a=
rray
> > > of BPF ringbufs to scale throughput. You can do 1 ringbuf per each CP=
U for
> > > ultimate performance at the expense of memory usage (that's perf ring
> > > buffer setup), but BPF ringbuf is flexible enough to allow any topolo=
gy that
> > > makes sense for you use case, from 1 shared ringbuf across all CPUs, =
to
> > > anything in between.
> > > >
> > > >

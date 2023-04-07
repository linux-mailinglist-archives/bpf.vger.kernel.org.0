Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BE6DB0B9
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDGQfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDGQfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 12:35:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CC4C08;
        Fri,  7 Apr 2023 09:35:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g19so41051909qts.9;
        Fri, 07 Apr 2023 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680885348; x=1683477348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ovg6vpl5tz4lpBsc6UiXfGPggdun5wUiuPiUleX5xs=;
        b=fhIJUiLsceDxwa6gtENKcJc39hakFz10lrcpJRBzdjs+w2CSqeRg9FTufL9A6wA8b7
         RXOvRrwAEqcOFTw70h/wBYyDQVsirf5m1qth7ff15Mgxd/et3nqt7Fq8lHUm4kv272ou
         PXyunZ/h77lIwvIQs+/v2GSPkWoVvPv9FdJgM0difcLMaIIIDH5gpX7gSnitRK3P14Ua
         B1CS0ZosZXxX4w1NBqQf/996CSsExmlHIoGSVfzNClIaKGWkxCa97TKymCms/jEe2u3q
         j2SKWp8qu9c4edzVD0ihpOo+EkZs/QXQcCksWtNy2oeYxEcGx+jKWuzdcr1i0c6BpvzX
         aNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680885348; x=1683477348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ovg6vpl5tz4lpBsc6UiXfGPggdun5wUiuPiUleX5xs=;
        b=0Fy4kXIrImARF/GbYlunvZnaB5ganB0mLK1PqU+WyOHldGhQQqmnj1PiyZZ2p4SXQP
         zunaxE1h9TDejw+5K9hytEbFTavjr+ETbBE6OM44riTqCUAbjVeDUpInTzQhfWJyfWGr
         FkNGw4yHdkUBdf970Gd3pQS3LcESfuUT0vxx7c9YiNOnIcu884Z3OM56+7+tVJcqyjXl
         fhTF2VB5MXs9Kj4oYrnz7aq0QJA1kp6CczczpXZYTCvHxaYbYPueUoyV98AL7p3w/Q+W
         LoArh3IVuQsP2DviMHzrL+C4wKQOjH29N4/S9gybyBa5ZON5pSoyLMmiwauzpKiU5E/K
         vvGw==
X-Gm-Message-State: AAQBX9et1dA5HPXa3ZYFwRQwTBZVIwdXSY3WsOO+VnOEw9LrH9SW/HaM
        iUkYjP/4HQvmRNy9IOJerGh50manjgDN0AzL98U=
X-Google-Smtp-Source: AKy350bOjsdhCyTklH7dQfml7Dl03ytSt4QXoMke+titCpziQaMfAtdDQbhaUs8Y4tKqL4qkPWpKuuLNtKLD6rWvx+w=
X-Received: by 2002:a05:622a:1a0a:b0:3e3:f70f:fb13 with SMTP id
 f10-20020a05622a1a0a00b003e3f70ffb13mr890727qtb.6.1680885348280; Fri, 07 Apr
 2023 09:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
 <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
 <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
 <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com>
 <CALOAHbDdtj1Qd0h1jzXKN4R=_webEVW=sqYfhSFXXsYftyvnKw@mail.gmail.com>
 <CAEf4Bza_vM8HE5g+4ANW3NAAt8=+cn7Lw+DSkH42gimqzYxPdw@mail.gmail.com>
 <20230407014359.m6tff5ffemvrsyt3@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAEf4BzaBd9y1O_u-ixr+OGiKarHfX95iHUSGtpSbGnrayg7=zQ@mail.gmail.com>
 <CAADnVQJ6LSxZ3=x9AnqiYObYaSnKQj1mWB0CzSn2c4PGRmSUSw@mail.gmail.com>
 <CALOAHbCwqV2x-HPcq5nr8W_xEKyJMHO6N7TbtDdWfqkC9fsSaw@mail.gmail.com> <CAADnVQKwqM6Fnbf+nQetpsoVY8NamQMMhshuAX7tGeHbrHPO_g@mail.gmail.com>
In-Reply-To: <CAADnVQKwqM6Fnbf+nQetpsoVY8NamQMMhshuAX7tGeHbrHPO_g@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 8 Apr 2023 00:35:11 +0800
Message-ID: <CALOAHbBmM_ZinWmVpxxJ3Rx08OxgQYAaQ9McA-03-JsLfokYCA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 8, 2023 at 12:32=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 7, 2023 at 9:22=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Sat, Apr 8, 2023 at 12:05=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Apr 7, 2023 at 8:59=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 6, 2023 at 6:44=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Apr 06, 2023 at 01:22:26PM -0700, Andrii Nakryiko wrote:
> > > > > > On Wed, Apr 5, 2023 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 6, 2023 at 12:24=E2=80=AFPM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.s=
hao@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoito=
v
> > > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <lao=
ar.shao@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > It seems that I didn't describe the issue clearly.
> > > > > > > > > > > The container doesn't have CAP_SYS_ADMIN, but the CAP=
_SYS_ADMIN is
> > > > > > > > > > > required to run bpftool,  so the bpftool running in t=
he container
> > > > > > > > > > > can't get the ID of bpf objects or convert IDs to FDs=
.
> > > > > > > > > > > Is there something that I missed ?
> > > > > > > > > >
> > > > > > > > > > Nothing. This is by design. bpftool needs sudo. That's =
all.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hmm, what I'm trying to do is make bpftool run without su=
do.
> > > > > > > >
> > > > > > > > This is not a task that is worth solving.
> > > > > > > >
> > > > > > >
> > > > > > > Then the container with CAP_BPF enabled can't even iterate it=
s bpf progs ...
> > > > > >
> > > > > > I'll leave the BPF namespace discussion aside (I agree that it =
needs
> > > > > > way more thought).
> > > > > >
> > > > > > I am a bit surprised that we require CAP_SYS_ADMIN for GET_NEXT=
_ID
> > > > > > operations. GET_FD_BY_ID is definitely CAP_SYS_ADMIN, as they a=
llow
> > > > > > you to take over someone else's link and stuff like this. But j=
ust
> > > > > > iterating IDs seems like a pretty innocent functionality, so ma=
ybe we
> > > > > > should remove CAP_SYS_ADMIN for GET_NEXT_ID?
> > > > > >
> > > > > > By itself GET_NEXT_ID is relatively useless without capabilitie=
s, but
> > > > > > we've been floating the idea of providing GET_INFO_BY_ID (not b=
y FD)
> > > > > > for a while now, and that seems useful in itself, as it would i=
ndeed
> > > > > > help tools like bpftool to get *some* information even without
> > > > > > privileges. Whether those GET_INFO_BY_ID operations should retu=
rn same
> > > > > > full bpf_{prog,map,link,btf}_info or some trimmed down version =
of them
> > > > > > would be up to discussion, but I think getting some info withou=
t
> > > > > > creating an FD seems useful in itself.
> > > > > >
> > > > > > Would it be worth discussing and solving this separately from
> > > > > > namespacing issues?
> > > > >
> > > > > Iteration of IDs itself is fine. The set of IDs is not security s=
ensitive,
> > > > > but GET_NEXT_BY_ID has to be carefully restricted.
> > > > > It returns xlated, jited, BTF, line info, etc
> > > > > and with all the restrictions it would need something like
> > > > > CAP_SYS_PTRACE and CAP_PERFMON to be useful.
> > > > > And with that we're not far from CAP_SYS_ADMIN.
> > > > > Why bother then?
> > > >
> > > > You probably meant that GET_INFO_BY_ID should be carefully restrict=
ed?
> > >
> > > yes.
> > >
> > > > So yeah, that's what I said that this would have to be discussed
> > > > further. I agree that returning func/line info, program dump, etc i=
s
> > > > probably a privileged part. But there is plenty of useful info besi=
des
> > > > that (e.g., prog name, insns cnt, run stats, etc) that would be use=
ful
> > > > for unpriv applications to monitor their own apps that they opened
> > > > from BPF FS, or just some observability daemons.
> > > >
> > > > There is a lot of useful information in bpf_map_info and bpf_link_i=
nfo
> > > > that's way less privileged. I think bpf_link_info is good as is. Sa=
me
> > > > for bpf_map_info.
> > > >
> > > > Either way, I'm not insisting, just something that seems pretty sim=
ple
> > > > to add and useful in some scenarios. We can reuse existing code and
> > > > types for GET_INFO_BY_FD and just zero-out (or prevent filling out)
> > > > those privileged fields you mentioned. Anyway, something to put on =
the
> > > > backburner, perhaps.
> > >
> > > Sorry, but I only see negatives. It's an extra code in the kernel
> > > that has to be carefully reviewed when initially submitted and
> > > then every patch that touches get_info_by_id would have to go
> > > through a microscope every time to avoid introducing a security issue=
.
> > > And for what? So that CAP_BPF application can read prog name and run =
stats?
> >
> > Per my experience, observability is a very important part for a
> > project. If the user can't observe the object directly created by it,
> > he will worry about or even mistrust it.
>
> The user can observe the objects just fine. That's what get_info_by_fd is=
 for.
> But the kernel will not report JITed instructions to unpriv user who
> just loaded a prog and a sole owner of it.

There's no UAPI to create the JITed instructions directly per my
understanding. The JITed instructions are created by the kernel.
While they're really UAPI to create a map, prog, and link.

> By your definition such a user should not trust the kernel. So be it.



--=20
Regards
Yafang

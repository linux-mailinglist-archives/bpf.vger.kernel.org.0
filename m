Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873A6DB072
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDGQWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDGQWf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 12:22:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7AB75B;
        Fri,  7 Apr 2023 09:22:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cn12so37696633qtb.8;
        Fri, 07 Apr 2023 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680884554; x=1683476554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYSQnvKRLGAqrNMignY9ToUj669QL5/nlNuRlmJb47U=;
        b=lbMZuEnIn9Ge2aKAOCiX5JP3ihgO3JddBv3q1JH2GSiA/oMMxnDwfBFyGTHHLm68VM
         NA7DR8FNYe3/1+v0iP+K9TIFSD39LmBEshrN39gKx/S3uT98GhFwdtJCMSNt3o1KBrwR
         Tu3wbnZNv3lazkSAmWbKMjkHYkg0RmfeupStgvBwxeoFsQNW2ossqAPe/10jozumkItt
         f5vtPBiEOllLXvIkyN8WoOBfcTrFniK+SLg5a0KVe7hffFVsgainc6O10oUyz9cAqaIb
         9KoOazhIQl+ZBEZvCOMfKvKpRFGEvFBT4KmpwJtUqy/tMUxbgFtpIn95aeKIEGprslID
         pWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884554; x=1683476554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYSQnvKRLGAqrNMignY9ToUj669QL5/nlNuRlmJb47U=;
        b=SaTw/u7v4k+tSI6GGbxWHD37hBBCW6XuakBrMEGl4ycEe10ulzVCl4DcIpFv9lwtI7
         3TFjO6Q2vnT8CORATBiIBhK2kQjS2D8teTF/iBg9YcI1ogfUuqKf+8CUkwkeB9KXIzkL
         8KAAFW0rwtuABeZFrEWWYYKwrDahHmBHMds3hh+MQzDJsfCPAruYU9xBALFArWS3Vjm/
         hghFKb4cfkMfX7w39CJpcKfVJ5E+TbHrLF+/hbRuw6+FtbPnjgQRGa58lyPRMQNgUcQf
         t95iRIdme6NR/oq5+pQptA2JppR6KNNZaKrAksO5x+BmsILT99yAjb9KrIDx7ivB0VVK
         nXTQ==
X-Gm-Message-State: AAQBX9cmUxBi0l3n8M0232Kkzn7Byvi4vsaOxaUzXU1lXaHytltqR9PM
        wtVevbrWUKP9/JlmJdo2r5Uw6+zz7IFp8A04Ycw=
X-Google-Smtp-Source: AKy350Zn/pSHOKdMHPBjbDJSK1kawmCl/XX23RuQNoKA/AUvSoQNW0nZd51NNnc3ccC+8N8nq4xfbSQWvt19gKsYE4A=
X-Received: by 2002:a05:622a:1828:b0:3df:4392:1aff with SMTP id
 t40-20020a05622a182800b003df43921affmr984769qtc.6.1680884553979; Fri, 07 Apr
 2023 09:22:33 -0700 (PDT)
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
 <CAEf4BzaBd9y1O_u-ixr+OGiKarHfX95iHUSGtpSbGnrayg7=zQ@mail.gmail.com> <CAADnVQJ6LSxZ3=x9AnqiYObYaSnKQj1mWB0CzSn2c4PGRmSUSw@mail.gmail.com>
In-Reply-To: <CAADnVQJ6LSxZ3=x9AnqiYObYaSnKQj1mWB0CzSn2c4PGRmSUSw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 8 Apr 2023 00:21:56 +0800
Message-ID: <CALOAHbCwqV2x-HPcq5nr8W_xEKyJMHO6N7TbtDdWfqkC9fsSaw@mail.gmail.com>
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

On Sat, Apr 8, 2023 at 12:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 7, 2023 at 8:59=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 6, 2023 at 6:44=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 06, 2023 at 01:22:26PM -0700, Andrii Nakryiko wrote:
> > > > On Wed, Apr 5, 2023 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > On Thu, Apr 6, 2023 at 12:24=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.shao@=
gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.s=
hao@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > It seems that I didn't describe the issue clearly.
> > > > > > > > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS=
_ADMIN is
> > > > > > > > > required to run bpftool,  so the bpftool running in the c=
ontainer
> > > > > > > > > can't get the ID of bpf objects or convert IDs to FDs.
> > > > > > > > > Is there something that I missed ?
> > > > > > > >
> > > > > > > > Nothing. This is by design. bpftool needs sudo. That's all.
> > > > > > > >
> > > > > > >
> > > > > > > Hmm, what I'm trying to do is make bpftool run without sudo.
> > > > > >
> > > > > > This is not a task that is worth solving.
> > > > > >
> > > > >
> > > > > Then the container with CAP_BPF enabled can't even iterate its bp=
f progs ...
> > > >
> > > > I'll leave the BPF namespace discussion aside (I agree that it need=
s
> > > > way more thought).
> > > >
> > > > I am a bit surprised that we require CAP_SYS_ADMIN for GET_NEXT_ID
> > > > operations. GET_FD_BY_ID is definitely CAP_SYS_ADMIN, as they allow
> > > > you to take over someone else's link and stuff like this. But just
> > > > iterating IDs seems like a pretty innocent functionality, so maybe =
we
> > > > should remove CAP_SYS_ADMIN for GET_NEXT_ID?
> > > >
> > > > By itself GET_NEXT_ID is relatively useless without capabilities, b=
ut
> > > > we've been floating the idea of providing GET_INFO_BY_ID (not by FD=
)
> > > > for a while now, and that seems useful in itself, as it would indee=
d
> > > > help tools like bpftool to get *some* information even without
> > > > privileges. Whether those GET_INFO_BY_ID operations should return s=
ame
> > > > full bpf_{prog,map,link,btf}_info or some trimmed down version of t=
hem
> > > > would be up to discussion, but I think getting some info without
> > > > creating an FD seems useful in itself.
> > > >
> > > > Would it be worth discussing and solving this separately from
> > > > namespacing issues?
> > >
> > > Iteration of IDs itself is fine. The set of IDs is not security sensi=
tive,
> > > but GET_NEXT_BY_ID has to be carefully restricted.
> > > It returns xlated, jited, BTF, line info, etc
> > > and with all the restrictions it would need something like
> > > CAP_SYS_PTRACE and CAP_PERFMON to be useful.
> > > And with that we're not far from CAP_SYS_ADMIN.
> > > Why bother then?
> >
> > You probably meant that GET_INFO_BY_ID should be carefully restricted?
>
> yes.
>
> > So yeah, that's what I said that this would have to be discussed
> > further. I agree that returning func/line info, program dump, etc is
> > probably a privileged part. But there is plenty of useful info besides
> > that (e.g., prog name, insns cnt, run stats, etc) that would be useful
> > for unpriv applications to monitor their own apps that they opened
> > from BPF FS, or just some observability daemons.
> >
> > There is a lot of useful information in bpf_map_info and bpf_link_info
> > that's way less privileged. I think bpf_link_info is good as is. Same
> > for bpf_map_info.
> >
> > Either way, I'm not insisting, just something that seems pretty simple
> > to add and useful in some scenarios. We can reuse existing code and
> > types for GET_INFO_BY_FD and just zero-out (or prevent filling out)
> > those privileged fields you mentioned. Anyway, something to put on the
> > backburner, perhaps.
>
> Sorry, but I only see negatives. It's an extra code in the kernel
> that has to be carefully reviewed when initially submitted and
> then every patch that touches get_info_by_id would have to go
> through a microscope every time to avoid introducing a security issue.
> And for what? So that CAP_BPF application can read prog name and run stat=
s?

Per my experience, observability is a very important part for a
project. If the user can't observe the object directly created by it,
he will worry about or even mistrust it.
However I don't insist on it either if you think we shouldn't do it.

--=20
Regards
Yafang

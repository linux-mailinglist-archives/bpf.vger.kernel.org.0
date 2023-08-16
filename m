Return-Path: <bpf+bounces-7913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A277E646
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA151C21123
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D11216436;
	Wed, 16 Aug 2023 16:24:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E80C8FF
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 16:24:27 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02733198C
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:24:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58419517920so71980567b3.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203065; x=1692807865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnywXpHlI6ay7Ck0Rlvm7S9jZvim3Y/ZQMiOdbgHj3A=;
        b=mifFKGImVtBOZ29dtIlB+s6qMEvoQu7RqhL9y0tITJm03OcElMUBazinOspBvHup5I
         Hc8MYi7z7RmndPf2cWWzqN6xNf90EKnAMfJKIPlTTasXTa8RKI9wEmSfqgwyWdHUulBK
         Dh5uJq70pIUc35u63owMRG64MhHz+wpotmNdID8q6JqUNojyegsOdPpa/8fPLofo5MLK
         nGeVj6jLm0yvlmiY8cfycsThbkxkiQFP8i8TdJYNvEpsDfPxcTdR1oqxVQiOLAgAD5gy
         IYDzaXxjUeRQG6PcW7IGMLGOKSopT3gS/4qDviCpMoL+e8iX0vE0gGUEf/axSlDLgnvB
         3WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203065; x=1692807865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnywXpHlI6ay7Ck0Rlvm7S9jZvim3Y/ZQMiOdbgHj3A=;
        b=OUJ730y1dahfraLxwSmEFH0PussqLDEZDUDYySxAmAcsUqiFq+NBVR0IsM7RKF2D+A
         fTtY6j8v9ag9k7q8jK/eYz/QRsuoQa5jQnn30+jNGY7bZyBQrxry2pA2Ykup/KW7Vtuz
         vdGxaHrCtfVtfGdFoxeUoZENndFsGLFwxOXaeOLxUVurtjOF35Nt3W7iBOktnh/Q3p21
         MQpJSuA/A4Anz7Sk4c2vfoyAlrjX3zTnewAGQBoehHHX98UWsrfSYr6rCDqS30mRnS5G
         6TjZRLdI9xb1Y7awS+FPJzbq9VGAcuuoo7AQ4t9NpMf/rNGUUcdVB0EkdZh+jFq8MujW
         TOeA==
X-Gm-Message-State: AOJu0YySUcr2gLdm5Dcysn7/4kLE6eUQ5Z1xo+n5/WmTaZcWAmNfc9ja
	BArW6bSQ+jeTptVCkZcyAi9rpIvnCdAv+315Whhv/gCcfd27Bw==
X-Google-Smtp-Source: AGHT+IH2YTE3GDkUJROPdPqZBiQDJXMSOb14qPaRfvWfb99lx/hvZm+aTcvVq3DmjEro/XggnTqt7Tx+8GFX2+40aUk=
X-Received: by 2002:a67:e3c6:0:b0:430:e0:ac2e with SMTP id k6-20020a67e3c6000000b0043000e0ac2emr2419624vsm.15.1692203044669;
 Wed, 16 Aug 2023 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816095651.10014-1-daniel@iogearbox.net> <CALOAHbDtmTPV6enF1M0RnZr4pPyWkr1bZ7afcFchfNYRGVKu7w@mail.gmail.com>
 <d25d1dc0-d4fc-eb0c-e9cf-ee3d4783e07a@iogearbox.net>
In-Reply-To: <d25d1dc0-d4fc-eb0c-e9cf-ee3d4783e07a@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 17 Aug 2023 00:23:26 +0800
Message-ID: <CALOAHbBxBgtLP=4mxJRF3w3XkbZKDRB=1kkQ290Jw6-8SZZSRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Implement link show support for tcx
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 11:11=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/16/23 4:23 PM, Yafang Shao wrote:
> > On Wed, Aug 16, 2023 at 5:56=E2=80=AFPM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> Add support to dump tcx link information to bpftool. This adds a
> >> common helper show_link_ifindex_{plain,json}() which can be reused
> >> also for other link types. The plain text and json device output is
> >> the same format as in bpftool net dump.
> >>
> >> Below shows an example link dump output along with a cgroup link
> >> for comparison:
> >>
> >>    # bpftool link
> >>    [...]
> >>    10: cgroup  prog 1977
> >>          cgroup_id 1  attach_type cgroup_inet6_post_bind
> >>    [...]
> >>    13: tcx  prog 2053
> >>          ifindex enp5s0(3)  attach_type tcx_ingress
> >>    14: tcx  prog 2080
> >>          ifindex enp5s0(3)  attach_type tcx_egress
> >>    [...]
> >>
> >> Equivalent json output:
> >>
> >>    # bpftool link --json
> >>    [...]
> >>    {
> >>      "id": 10,
> >>      "type": "cgroup",
> >>      "prog_id": 1977,
> >>      "cgroup_id": 1,
> >>      "attach_type": "cgroup_inet6_post_bind"
> >>    },
> >>    [...]
> >>    {
> >>      "id": 13,
> >>      "type": "tcx",
> >>      "prog_id": 2053,
> >>      "devname": "enp5s0",
> >>      "ifindex": 3,
> >>      "attach_type": "tcx_ingress"
> >>    },
> >>    {
> >>      "id": 14,
> >>      "type": "tcx",
> >>      "prog_id": 2080,
> >>      "devname": "enp5s0",
> >>      "ifindex": 3,
> >>      "attach_type": "tcx_egress"
> >>    }
> >>    [...]
> >>
> >> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> >
> > Thanks for your work. This patch looks good to me.
> > A minor nit below.
> >
> >> ---
> >>   tools/bpf/bpftool/link.c | 37 +++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 37 insertions(+)
> >>
> >> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> >> index 65a168df63bc..a3774594f154 100644
> >> --- a/tools/bpf/bpftool/link.c
> >> +++ b/tools/bpf/bpftool/link.c
> >> @@ -150,6 +150,18 @@ static void show_link_attach_type_json(__u32 atta=
ch_type, json_writer_t *wtr)
> >>                  jsonw_uint_field(wtr, "attach_type", attach_type);
> >>   }
> >>
> >> +static void show_link_ifindex_json(__u32 ifindex, json_writer_t *wtr)
> >> +{
> >> +       char devname[IF_NAMESIZE] =3D "(unknown)";
> >> +
> >> +       if (ifindex)
> >> +               if_indextoname(ifindex, devname);
> >> +       else
> >> +               snprintf(devname, sizeof(devname), "(detached)");
> >> +       jsonw_string_field(wtr, "devname", devname);
> >> +       jsonw_uint_field(wtr, "ifindex", ifindex);
> >> +}
> >> +
> >>   static bool is_iter_map_target(const char *target_name)
> >>   {
> >>          return strcmp(target_name, "bpf_map_elem") =3D=3D 0 ||
> >> @@ -433,6 +445,10 @@ static int show_link_close_json(int fd, struct bp=
f_link_info *info)
> >>          case BPF_LINK_TYPE_NETFILTER:
> >>                  netfilter_dump_json(info, json_wtr);
> >>                  break;
> >> +       case BPF_LINK_TYPE_TCX:
> >> +               show_link_ifindex_json(info->tcx.ifindex, json_wtr);
> >> +               show_link_attach_type_json(info->tcx.attach_type, json=
_wtr);
> >> +               break;
> >>          case BPF_LINK_TYPE_STRUCT_OPS:
> >>                  jsonw_uint_field(json_wtr, "map_id",
> >>                                   info->struct_ops.map_id);
> >> @@ -509,6 +525,22 @@ static void show_link_attach_type_plain(__u32 att=
ach_type)
> >>                  printf("attach_type %u  ", attach_type);
> >>   }
> >>
> >> +static void show_link_ifindex_plain(__u32 ifindex)
> >> +{
> >> +       char devname[IF_NAMESIZE * 2] =3D "(unknown)";
> >> +       char tmpname[IF_NAMESIZE];
> >> +       char *ret =3D NULL;
> >> +
> >> +       if (ifindex)
> >> +               ret =3D if_indextoname(ifindex, tmpname);
> >> +       else
> >> +               snprintf(devname, sizeof(devname), "(detached)");
> >> +       if (ret)
> >> +               snprintf(devname, sizeof(devname), "%s(%d)",
> >> +                        tmpname, ifindex);
> >> +       printf("ifindex %s  ", devname);
> >> +}
> >
> > This function looks a little strange to me. What about the change below=
?
> >
> > static void show_link_ifindex_plain(__u32 ifindex)
> > {
> >          char devname[IF_NAMESIZE] =3D "(unknown)";
> >
> >          if (ifindex) {
> >                  if_indextoname(ifindex, devname);
> >                  printf("ifindex %s(%d)  ", devname, ifindex);
> >          } else {
> >                  printf("ifindex (detached)  ");
> >          }
> > }
>
> Arguably, it's a corner case (and should never happen), but for the case
> where the if_indextoname call fails, I only intended to print `ifindex (u=
nknown)`
> for the plain mode hence the check for if_indextoname success so that thi=
s
> looks similar as `ifindex (detached)` situation.
>

Fair enough.

Then fail free to add :
Acked-by: Yafang Shao <laoar.shao@gmail.com>

--=20
Regards
Yafang


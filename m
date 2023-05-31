Return-Path: <bpf+bounces-1478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06D717445
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9102328140E
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920D8185C;
	Wed, 31 May 2023 03:17:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830CA4C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:17:30 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51152186
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:16:58 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6260e8a1424so22495946d6.2
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685503017; x=1688095017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh8teY4AXjxAGvotJEg3G4xjXnkepUAHTrvnIIkfmEI=;
        b=XmmXw4AdgjRlSAn8ZtDj59qYQDoF9ngFHro3J2cHVqup3gXP+NFX/As6JE9XRK2a9D
         zq2nZ2ZHn46UfhhNdwgeyhsgIKqfT6mVZLZkIiLiyoJPJWv0D7s5oDi1YOt2UehJkqlY
         +VYcGwqZS0BOTK/qVXEcnhOou0+WpUHOgZ3Ynuwg/r7zCIUO/SX+2ZfB9zksCCVAWrrL
         b9jMfivF3tqSa/6V3Qefmi9sk0y2u66z7EKnp8UTq8+8O/CVxCA2xiK2OvjnuhDRY4F+
         pH6AUu9VRJzAeo+ambYXScDmaiQCe1S5KB03mU4QBOOgMlSe77xJbj8xCk8qmxkknMbo
         kTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685503017; x=1688095017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh8teY4AXjxAGvotJEg3G4xjXnkepUAHTrvnIIkfmEI=;
        b=KHwg+YdyRGNQUJ2F6ZnE453Iouq09RS6zSV1H4n8MqI5mV3KhdUwDsBNgFSFIH6mSa
         HLi8FsFeUz0FcTIWAwmOdgLgWEhO+DfY7bV4FKyh6Ht/+q09GdOfL0o0v84kACgbnpOu
         ymzY2HheNyyGh4NaM64TVX0ZoJqLjvxdyhhpLn4GMZ43w/5CfSp5/FSSw8/IPTMvb3t/
         w815Mwh+w+UY9erazDCmTCC6NJEyKCSYvp1Ne1ZWGuUuqdGVVa8GMFdz9AZBshvGnkSZ
         3M/+5rxdNW/raswdJYbd6YCZOmKE/dxaWCFdgKLnOF8XGay/wakohYdfFqVvA0rXMHmO
         FKRQ==
X-Gm-Message-State: AC+VfDzk3ZT4sImn6Q1zdi91MJ1eXkoDQ1ty0ZvPnO8yLmF9pc6n8+8g
	jThoJKE99gKWYtCjh+241PainMMSYoLvnzHK0O4=
X-Google-Smtp-Source: ACHHUZ55HIEvutrbcbUqlTp4Zz3zLN+nprIYGFancVsTx2HfN9PK6LDprl1SilzZV19HzdAzm6GixArfVeAcEP9GVoA=
X-Received: by 2002:a05:6214:40a:b0:626:299b:68ee with SMTP id
 z10-20020a056214040a00b00626299b68eemr5003260qvx.55.1685503016975; Tue, 30
 May 2023 20:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230528142027.5585-1-laoar.shao@gmail.com> <20230528142027.5585-4-laoar.shao@gmail.com>
 <313a276f-aab9-42ed-e835-32261c25bb39@isovalent.com>
In-Reply-To: <313a276f-aab9-42ed-e835-32261c25bb39@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 May 2023 11:16:20 +0800
Message-ID: <CALOAHbAJscwrQthOSaYvqkmB2tOkkO2txXbTvZ9WvaBpAa39XA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/8] bpftool: Show probed function in
 kprobe_multi link info
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 30, 2023 at 7:16=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-05-28 14:20 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > $ bpftool link show
> > 2: kprobe_multi  prog 11
> >         func_cnt 4  addrs ffffffffaad475c0 ffffffffaad47600
> >                           ffffffffaad47640 ffffffffaad47680
> >         pids trace(10936)
> >
> > $ bpftool link show -j
> > [{"id":1,"type":"perf_event","prog_id":5,"bpf_cookie":0,"pids":[{"pid":=
10658,"comm":"trace"}]},{"id":2,"type":"kprobe_multi","prog_id":11,"func_cn=
t":4,"addrs":[18446744072280634816,18446744072280634880,1844674407228063494=
4,18446744072280635008],"pids":[{"pid":10936,"comm":"trace"}]},{"id":120,"t=
ype":"iter","prog_id":266,"target_name":"bpf_map"},{"id":121,"type":"iter",=
"prog_id":267,"target_name":"bpf_prog"}]
> >
> > $ bpftool link show  | grep -A 1 "func_cnt" | \
> >   awk '{if (NR =3D=3D 1) {print $4; print $5;} else {print $1; print $2=
} }' | \
> >   awk '{"grep " $1 " /proc/kallsyms" | getline f; print f;}'
> > ffffffffaad475c0 T schedule_timeout_interruptible
> > ffffffffaad47600 T schedule_timeout_killable
> > ffffffffaad47640 T schedule_timeout_uninterruptible
> > ffffffffaad47680 T schedule_timeout_idle
>
> Looks nice, thank you!
>
> The address is a useful addition, but I feel like most of the time, this
> is the actual function name that we'd like to see. We could maybe print
> it directly in bpftool, what do you think? We already parse
> /proc/kallsyms elsewhere (to get the address of __bpf_call_base()). If
> we can parse the file only once for all func_cnt function, the overhead
> is maybe acceptable?
>

Thanks for your suggestion. Will change it.

> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 50 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 2d78607..76f1bb2 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -218,6 +218,20 @@ static int show_link_close_json(int fd, struct bpf=
_link_info *info)
> >               jsonw_uint_field(json_wtr, "map_id",
> >                                info->struct_ops.map_id);
> >               break;
> > +     case BPF_LINK_TYPE_KPROBE_MULTI:
> > +             const __u64 *addrs;
> > +             __u32 i;
> > +
> > +             jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi=
.count);
> > +             if (!info->kprobe_multi.count)
> > +                     break;
>
> I'd as well avoid having conditional entries in the JSON output. Let's
> just keep 0 and empty array in this case?
>

Will do it.

> > +             jsonw_name(json_wtr, "addrs");
> > +             jsonw_start_array(json_wtr);
> > +             addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.ad=
drs);
> > +             for (i =3D 0; i < info->kprobe_multi.count; i++)
> > +                     jsonw_lluint(json_wtr, addrs[i]);
> > +             jsonw_end_array(json_wtr);
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -396,6 +410,24 @@ static int show_link_close_plain(int fd, struct bp=
f_link_info *info)
> >       case BPF_LINK_TYPE_NETFILTER:
> >               netfilter_dump_plain(info);
> >               break;
> > +     case BPF_LINK_TYPE_KPROBE_MULTI:
> > +             __u32 indent, cnt, i;
> > +             const __u64 *addrs;
> > +
> > +             cnt =3D info->kprobe_multi.count;
> > +             if (!cnt)
> > +                     break;
> > +             printf("\n\tfunc_cnt %d  addrs", cnt);
> > +             for (i =3D 0; cnt; i++)
> > +                     cnt /=3D 10;
> > +             indent =3D strlen("func_cnt ") + i + strlen("  addrs");
> > +             addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.ad=
drs);
> > +             for (i =3D 0; i < info->kprobe_multi.count; i++) {
> > +                     if (i && !(i & 0x1))
> > +                             printf("\n\t%*s", indent, "");
> > +                     printf(" %0*llx", 16, addrs[i]);
> > +             }
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -417,7 +449,9 @@ static int do_show_link(int fd)
> >  {
> >       struct bpf_link_info info;
> >       __u32 len =3D sizeof(info);
> > +     __u64 *addrs =3D NULL;
> >       char buf[256];
> > +     int count;
> >       int err;
> >
> >       memset(&info, 0, sizeof(info));
> > @@ -441,12 +475,28 @@ static int do_show_link(int fd)
> >               info.iter.target_name_len =3D sizeof(buf);
> >               goto again;
> >       }
> > +     if (info.type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI &&
> > +         !info.kprobe_multi.addrs) {
> > +             count =3D info.kprobe_multi.count;
> > +             if (count) {
> > +                     addrs =3D malloc(count * sizeof(__u64));
>
> Nit: calloc() instead?

Good point. Will do it.

>
> > +                     if (!addrs) {
> > +                             p_err("mem alloc failed");
> > +                             close(fd);
> > +                             return -1;
> > +                     }
> > +                     info.kprobe_multi.addrs =3D (unsigned long)addrs;
> > +                     goto again;
> > +             }
> > +     }
> >
> >       if (json_output)
> >               show_link_close_json(fd, &info);
> >       else
> >               show_link_close_plain(fd, &info);
> >
> > +     if (addrs)
> > +             free(addrs);
> >       close(fd);
> >       return 0;
> >  }
>
> The other bpftool patch (perf_event link) looks good to me.
>

Thanks for your review.

--=20
Regards
Yafang


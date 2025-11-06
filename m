Return-Path: <bpf+bounces-73763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE15C38B5D
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92D8134E972
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF4E2236EE;
	Thu,  6 Nov 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwLE4WPR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBB22256F
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392612; cv=none; b=K9fNoV2S9qLfjnGzaMa+XFlHL7RDTdwsJDfua48Qr7oHx8OrZLqvIcI5guq0D0iNeNsHPiFCTC6Fx5He89rHK91Sd3wfPWdCiCyJzGdpRm/AihVMrpYjaL3pk+UdDlOS6YK562SRd4G3Kxm0np54qaHPGQMCiJIPW8eKwYgjMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392612; c=relaxed/simple;
	bh=NkA6YQMsd3cE26swPPj5IvSf4rNy6eveXek+exPauMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJRP+xh4LiNBotu+11K05ubrcbC1+mlj2zFkFoILXknc14K3Sn9lRE5uTuakva6p+b91I8O8gCmLdvXln+N+d2i/pl+Yy9t8GWL064vhftQHKLIUTDOhg8NmK9u/Ui+mnKRcPy0LW4zr8DHi5Dp7Rc4fQaJt6ID/QXo/e+gKcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwLE4WPR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632cc932so839725e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 17:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762392608; x=1762997408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pglOosQTIvBfeYgOgvZ/bymKX6TWUK4RdH77mW1U80s=;
        b=YwLE4WPR3u/wDpXwTRvR0NS0lZnR87Deef7IDOdx+hR1QW8D2ZYtzZ4hoD6uTGgBZb
         eKp51udHCrcIcq2e12Ja/wFFYJEXE88vJxUgDRtXPCqVwjzuYwNegw8YrD93PuNzxb5H
         DJYNJ9td6iN3Vny14OdwK9BXXbRP34RIT424nJPLWIOQo/L+NdSmQO4BAY9oenW/6Enn
         PB1kicyRiDM7h8JQuB+FFy5PPNGRNroT/Knk+mLanK69LLPs+zIL8k2Q0lTGzY6gMthT
         Br9/GE8Jmo+Xu7oJkJnsDyc3d9KxeMwXVozHRHUJ+0J/7wdXHTR2neciFabhMJwLmhMK
         4AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762392608; x=1762997408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pglOosQTIvBfeYgOgvZ/bymKX6TWUK4RdH77mW1U80s=;
        b=tsTcIcWcR2bCS14NxIjC0ejPVJZTQJnrL700ypYZ+H+cLKphLsMGghKaeHjEyBHrVX
         HG/VWpi7GdBS+kL9dozi0HbV3FTkKo8NYpP9GQQjUPjd7KxgNdNfYEIUfev38Yesk7DA
         Hk9Ss8udEVbuvaSS0w5BnZVLvbA40oehEsEVn07UmnAHu67fkwTanZFJ3EqzMFOTlEay
         Jt7g40gbLwty01K4E5THVSB5Itw+mc5NMSb1YZY7YG/0ESlkCoLLzBxG3WxTVNonCnvx
         GoYJQkb/JoVr0a28laRlhw6QzBGaEbb/sZXlgxb04FY2eFlIaQ7vCQknB5945gVHm6u6
         EDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeQx/9kjh0hqQvdnmhbgWkvB2KvilTpsvEs3nI5O63IXjvrEcbabriAFkynfkgZ5sMoF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRrt8ZBzlpD04cC57pTFsUFb76MySBwHM0bm2cSbdJ8rYpvuU
	gsqp7IzsQUScDiHAi0yD1sh6oCYFtwuLsXbv0lJOCFfTeKDkLEOIihNGfTboKCiWjF3vKtzY7w3
	VJi+r06AYSn7/aNYaNeu5pT7EUTfjtKY=
X-Gm-Gg: ASbGnctC2CQX8x4xNNO0qfCcvnJgm0LrOXXuq8CzVaWsJHdeea9h1wlJDz8qC0tkCqs
	s2T4PhW/WTMjljTGcrWaLNl92uHaAq5ZpTr20Ho0MeH5eAOClus5Ao1c7+yv+j+TEg6n1ayFG1u
	WPIF3gApQEZH8iSWlMYNrXEdCAWdYXhlRRB27sb+2jl6ureRwweQRfx5QgDCXonZjoc9rN2i3iP
	URbKq3LjtZnsHPkr0OBn+Nt8D1iE/pVVc/tnK83JnvicAjSHG1M9k79Iez4AY3pOPGXgbKq7s9V
	UE5LcAV3JyWTW4UlH8IVVN89oVuQ
X-Google-Smtp-Source: AGHT+IHvs+3XbvYIb+ePg+SGtg47YLsx/nuhBwaLkrgMO/eh+y9lNIxImoFpX1haQWbxriNO9cGrZ9z1XYaVKY0YoC4=
X-Received: by 2002:a05:600c:5403:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-4775ce4fcc8mr40655025e9.37.1762392607821; Wed, 05 Nov 2025
 17:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
 <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com> <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org>
In-Reply-To: <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 17:29:56 -0800
X-Gm-Features: AWmQ_bny7FcaG0pHAt7j2zZd3I9EBcjh494p7XVJPwhzbfrPnw_3LfP8rxR-6LM
Message-ID: <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Quentin Monnet <qmo@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:38=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > On Sat, Nov 1, 2025 at 12:34=E2=80=AFPM Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com> wrote:
> >>
> >> It is useful to print map ID on successful creation.
> >>
> >> JSON case:
> >> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value =
8 entries 128 name map4
> >> {"id":12}
> >>
> >> Generic case:
> >> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 =
entries 128 name map5
> >> Map successfully created with ID: 15
> >>
> >> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> >> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >> ---
> >> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin=
]
> >> ---
> >>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
> >>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> >> index c9de44a45778..f32ae5476d76 100644
> >> --- a/tools/bpf/bpftool/map.c
> >> +++ b/tools/bpf/bpftool/map.c
> >> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
> >>         LIBBPF_OPTS(bpf_map_create_opts, attr);
> >>         enum bpf_map_type map_type =3D BPF_MAP_TYPE_UNSPEC;
> >>         __u32 key_size =3D 0, value_size =3D 0, max_entries =3D 0;
> >> +       struct bpf_map_info map_info =3D {};
> >> +       __u32 map_info_len =3D sizeof(map_info);
> >>         const char *map_name =3D NULL;
> >>         const char *pinfile;
> >>         int err =3D -1, fd;
> >> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
> >>         }
> >>
> >>         err =3D do_pin_fd(fd, pinfile);
> >> -       close(fd);
> >>         if (err)
> >> -               goto exit;
> >> +               goto close_fd;
> >>
> >> -       if (json_output)
> >> -               jsonw_null(json_wtr);
> >> +       err =3D bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> >> +       if (err) {
> >> +               p_err("Failed to fetch map info: %s", strerror(errno))=
;
> >> +               goto close_fd;
> >> +       }
> >>
> >> +       if (json_output) {
> >> +               jsonw_start_object(json_wtr);
> >> +               jsonw_int_field(json_wtr, "id", map_info.id);
> >> +               jsonw_end_object(json_wtr);
> >> +       } else {
> >> +               printf("Map successfully created with ID: %u\n", map_i=
nfo.id);
> >> +       }
> >
> > bpftool doesn't print it today and some scripts may depend on that.
>
>
> Hi Alexei, are you sure we can't add any input at all? I'm concerned
> that users won't ever find the IDs for created maps they might want to
> use, if they never see it in the plain output.
>
>
> > Let's drop this 'printf'. Json can do it unconditionally, since
> > json parsing scripts should filter things they care about.
>
> I'd say the risk is the same. Scripts should filter things, but in
> practise they might just as well be comparing to "null" today, given
> that we didn't have any other output for the command so far. Conversely,
> what scripts should not do is rely on plain output, we've always
> recommended using bpftool's JSON for automation (or the exit code, in
> the case of map creation). So I'm not convinced it's justified to
> introduce a difference between plain and JSON in the current case.

tbh the "map create" feature suppose to create and pin and if both
are successful then the map will be there and bpftool will
exit with success.
Now you're arguing that there could be a race with another
bpftool/something that pins a different map in the same location
and success of bpftool doesn't mean that exact that map is there.
Other tool could have unpinned/deleted map, pinned another one, etc.
Sure, such races are possible, but returning map id still
looks pointless. It doesn't solve any race.
So the whole 'lets print id' doesn't quite make sense to me.


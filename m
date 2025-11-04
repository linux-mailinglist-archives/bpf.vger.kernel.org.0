Return-Path: <bpf+bounces-73478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C982C32763
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E4774ED691
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465FD33C51A;
	Tue,  4 Nov 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q13PLcyz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE753396F3
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278905; cv=none; b=QF+u4kh7YQWWOd7C7R7XDLsZDOd6tHZBbU2G9rFia4DfvKiJVGO5jOgiepiGdpQRCQ1n9Oo7fT+4qEuekGrgOsz4OfuGerh4G90eXVLGFCp9CPlP0lHMZf5eQZYvOoRRLogZK26hUbpmGFQvv42XEKS8YnNRB/3UZG/pEbvjeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278905; c=relaxed/simple;
	bh=Gga7dXHfeLZzklbXPavpEZ6reid9hn2IxaGkYVec1c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKqYDDHlEtfP1MfCM2Y07o24r8y+bLGBtqghunmXkFGJ7aq6dAHzNYaa43xUHY73XT84/LvK8WFanfJEo7DjgEgLkaDueHxfdOoFgLyjXSaVvz9ma8sc9DKvwGCZ3K71wfN6FnZHvUA7aBVWytGuLamEIPIVnLXHF7Kh5rPlHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q13PLcyz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426f1574a14so3565565f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278902; x=1762883702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50v8erXAUCAdx13yfjVbwgmCtzNJs2FIBxB/mDOxFDY=;
        b=Q13PLcyzU2m1i6h2vXE0m3pFQt4Vluus3MVSbQfcu6UKjfPInLoFGtQPsUB0G6Ct1A
         BF5iw2IBtlDSe605vxYA3n0nxP/vsYU3j1kDXvUEYkbgN5jBpE4TJoGf8/3jdbWOTbJg
         mmfRUTtOnCQkMeqQ2II8+jo6sBzgISQW1qkUyrsChK6UcxYrA3sLMEKWJoPSn2KvWtYc
         EeIE0p0p0dSPrwomwoF+lWClg8AiFuR8zLPxhUSMXuPPKbSma3hdYSsBk+v31mqTbNvs
         ojXzPf8m+Yelh/KS2b5KPSIjhYB95oPSsGcqd4JURpXNg13Q1OewWRKUhCgZTIeqnkWc
         t8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278902; x=1762883702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50v8erXAUCAdx13yfjVbwgmCtzNJs2FIBxB/mDOxFDY=;
        b=xDZnMbIg56Ei6+oEB5YSOFvQdBWT/gNHwNNuoQRv9OHzelAN2vibatLuf6eGj5Kjz1
         8FKNlttKQgUG2KYqmckWUdr4AYLMgxz9GCoLIYViR6GaZUQP0nf0KZAurhXkajlcsP5A
         X4fM8CBku6rNz1keFm2wUmYy2jSTEjjiwFb4KrvQkLvzNKgFYEi9Vf8tt3Y2T/2TSuZJ
         pJ9YWAhOHYnZAahlQy2ChAJf9VgWYdf4+RHZKkBI2ibcs/OqeoT6E78NFLCNa9aRyPyg
         LOR1CSTLLcWuORY4zGmGNn9hW23ccHKd2NBxAX8tTpdlCrIGUehR9CKObaVUooYZs+fK
         azvQ==
X-Gm-Message-State: AOJu0YwrdRABaW7RAzy1KHTKFVC3Tuav2wVxhZZrPY5m3Cw98bI/0eFu
	PMgyfOjXMXLXUmSD7uhzm9i/E4TK2RaaGG/nFg3MrAFaXk1qw7TrrCgdBF7Z+pER1wYIQB2i7J0
	WVZ0gRJYVLDs7QJAPXQJo2bxyKrcrE1A=
X-Gm-Gg: ASbGncvs1anfJzCI+yqZTj/+oGlrHanWNF1GtkMJq3Dqzww0fMi2ARx+ExwDqp8TQxl
	RpkJPOYQro77OxQAUpFhrKgs8oEFxyHTbCTcGNsuycx2IQE2Qnro+8BJFeFDKAZr61RK34OXEBc
	JTsb3BoBI2Q+vo0TD8cMhWjRqxoynH+KH5uQ4FYb8yW4VO8d8aZC5vlZezBVgwm+/9lHHp80XZz
	Ib7hIt6GxBEhYFRAyRzIh4d6m/jH/fK2RAjTHl4Br+Rs0WF4sX/IAQwwtflNrrPy/iWcHtNkyQK
X-Google-Smtp-Source: AGHT+IHe2cvX79ByF/XHXoC1AinxfdR+R2HeAxrfHYrpUAc4i7jUKc7LNBvEX5vIHDigGXEpVUk/JIQwCndvI8NbwXw=
X-Received: by 2002:a05:6000:258a:b0:427:928:7888 with SMTP id
 ffacd0b85a97d-429e3311aeamr109738f8f.55.1762278901733; Tue, 04 Nov 2025
 09:55:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com> <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 09:54:48 -0800
X-Gm-Features: AWmQ_bl7Wg5Ky0fAkADoe6a4uQMdjWgFSAOgbvmIWoV-HRcw0uHzFSIXFgIJbpE
Message-ID: <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:34=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> It is useful to print map ID on successful creation.
>
> JSON case:
> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 e=
ntries 128 name map4
> {"id":12}
>
> Generic case:
> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 ent=
ries 128 name map5
> Map successfully created with ID: 15
>
> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
> ---
>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45778..f32ae5476d76 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>         LIBBPF_OPTS(bpf_map_create_opts, attr);
>         enum bpf_map_type map_type =3D BPF_MAP_TYPE_UNSPEC;
>         __u32 key_size =3D 0, value_size =3D 0, max_entries =3D 0;
> +       struct bpf_map_info map_info =3D {};
> +       __u32 map_info_len =3D sizeof(map_info);
>         const char *map_name =3D NULL;
>         const char *pinfile;
>         int err =3D -1, fd;
> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>         }
>
>         err =3D do_pin_fd(fd, pinfile);
> -       close(fd);
>         if (err)
> -               goto exit;
> +               goto close_fd;
>
> -       if (json_output)
> -               jsonw_null(json_wtr);
> +       err =3D bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +       if (err) {
> +               p_err("Failed to fetch map info: %s", strerror(errno));
> +               goto close_fd;
> +       }
>
> +       if (json_output) {
> +               jsonw_start_object(json_wtr);
> +               jsonw_int_field(json_wtr, "id", map_info.id);
> +               jsonw_end_object(json_wtr);
> +       } else {
> +               printf("Map successfully created with ID: %u\n", map_info=
.id);
> +       }

bpftool doesn't print it today and some scripts may depend on that.
Let's drop this 'printf'. Json can do it unconditionally, since
json parsing scripts should filter things they care about.

pw-bot: cr


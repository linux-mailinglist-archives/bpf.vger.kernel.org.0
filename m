Return-Path: <bpf+bounces-67602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9763FB46355
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C0E18937CF
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D41DA60F;
	Fri,  5 Sep 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq3zsAlG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCC27A909
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099673; cv=none; b=M3kTUVkE7IbVtxZ3ZmVsm4rC1FJf4gtwSLWkloHYCesNtbamM33RBq6+EDPrRT7//cd28L4NctzbENXwXXsKX4+T3qKcV+Wx+PRS5AqChIZCwn+p43kwJvl6T7+ib0eQL5bjJTIXG47WQQwqftEAi9fZrdr2fnXi8MwWfYf4ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099673; c=relaxed/simple;
	bh=C/j1PXHWpLKvlia5b3dEtmij5w345jW2KpSbDgCuZRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK5EL9K7ggZFbJC0hY/9IyIfhZTubp85vDUf0nPJtpKMykYkoMjreV8UKSGlprdvY/XCZkOZCTgsrQz6b83HJB41U6MEXGfIxClcrhQ2xzCJ94GNrMz+0rT7BE8/buzCUmTvFtog9qepO+DZz8GqSl9Zdx56AUyHQwzbeh8MQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq3zsAlG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso1523439a12.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099671; x=1757704471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fQwFRqjOpoV8/n5hpwwOpfN2KFIpzSuNoTNnxruZJE=;
        b=aq3zsAlGb4dH15+3eUTNSXdjRMciG6p17ahb9a+Sidcg21FtQy4aflLWNZ//l/TOhS
         ghfm1Ola/fwvWD/0edGrjrjtTNq6bybm1ju8t7JOHgY5chIrblhgzI71GSodSEKbPRhM
         pcR3U28OpoxWKG8/HSLjtClwI+hByMeVlLIOc0hb3rsnWVeUOMagA1EycJX8k4pW7gJy
         O85p+Lq1BAzCgFi32LwVGvPUFLQH6IaU0u6hBrCa8d2fwVWLrPhFAv6rI2/FSKNy5Os6
         Q3/y0X0AnZy2HGCE5SXERcWTjDoh1ad7YBnJKfWMZOGWy0XADwFszSDRxGDTtpGepDPF
         0reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099671; x=1757704471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fQwFRqjOpoV8/n5hpwwOpfN2KFIpzSuNoTNnxruZJE=;
        b=bKcl/R1MkyhZ1+TvuOONzOciyOc0pYdZnGB8/M6U+84BsjxiEcL5dip/CFqpgxusdw
         IBNA08BbCzsXJTD38foWHP0lppdLeZh4ftrww9FdGFt1uDeacjdYmD0BetI+q/2duNQx
         qRD6L+L9KL0h4hQYsp14/3mSy0z5qpmAVdf+DHiSDoK43R7T07CfBzJ3gvtinRmqK6lF
         bUJDxLhDPQABfFztP/Xvn9AGlGYkScBN1ekiuqmsnpGgXZVu5kKFbAWIrD2eeN8N1Vxq
         mR7JFh70udkngHbNKwDcF22sjK6ac1M0YQSdX7brCixd2yqprfvcpkx6BTaOxkdED1P4
         9+hg==
X-Forwarded-Encrypted: i=1; AJvYcCWLN3inLXKkTYp/lTjwVViomvyjdDw950DePC5+DeBEC5AnxAqWe3EWtxkmi1MnsJC3Rpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzymbUAuU9XMn5HUPdwLMVRumlPNSe8PJqg9pi6bG6ZBkQysQpI
	/m4QBmHWDUhIII2LN7nh/mxZr3RvkYY3RMvcseiG36vjwxwES9kFP7pdcm7CN+iuKWi/ZXcb0he
	3sZoBZoFRRtli//ms1YGFebXH10mbQHw=
X-Gm-Gg: ASbGncs4S72f4Zf+9ZquUPbav8GE/vTKVJWsGlRdccqeSk+QcsEgcM8E7IAnQ8NgmxR
	uezqiIbpYytn524EGSbE1DssNFZ3ZyK3ZzhPno8tE3cSI1T5RittSUWyhZaOF0q+jk0bdR6JDof
	LWsuzE/YaWDzeSPq3YtfdCVwgjfuhF+wI94k5NYeZ0qXI0ho9a80XaxoH/MTR6NxlkhK0TYDa0Z
	UKLuyiYlKLvRa8=
X-Google-Smtp-Source: AGHT+IHa5KKZ3n2h6uO3Yd9Kp954l+vfiRu+bd8BRfKKGf7gsxN/fdTf9c+7nrW45ZK5MO+8/BirgKcpBF+vBPudoHY=
X-Received: by 2002:a17:90b:2802:b0:32b:9506:1773 with SMTP id
 98e67ed59e1d1-32b950618b8mr10291726a91.33.1757099670831; Fri, 05 Sep 2025
 12:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com> <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
In-Reply-To: <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 12:14:19 -0700
X-Gm-Features: Ac12FXxR8AoOGT-jIHdJMDZsRIudpq77-64Er7xGYxO-uMyA7w-bFkGqt9eUSPk
Message-ID: <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-09-05 at 15:08 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Add the ability to dump BPF program instructions directly from veristat=
.
> > Previously, inspecting a program required separate bpftool invocations:
> > one to load and another to dump it, which meant running multiple
> > commands.
> > During active development, it's common for developers to use veristat
> > for testing verification. Integrating instruction dumping into veristat
> > reduces the need to switch tools and simplifies the workflow.
> > By making this information more readily accessible, this change aims
> > to streamline the BPF development cycle and improve usability for
> > developers.
> > This implementation leverages bpftool, by running it directly via popen
> > to avoid any code duplication and keep veristat simple.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> Lgtm with a small nit.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> > @@ -1554,6 +1573,35 @@ static int parse_rvalue(const char *val, struct =
rvalue *rvalue)
> >       return 0;
> >  }
> >
> > +static void dump(__u32 prog_id, enum dump_mode mode, const char *file_=
name, const char *prog_name)
> > +{
> > +     char command[64], buf[4096];
> > +     FILE *fp;
> > +     int status;
> > +
> > +     status =3D system("which bpftool > /dev/null 2>&1");
>
> Fun fact: if you do a minimal Fedora install (dnf group install core)
>           "which" is not installed by default o.O
>           (not suggesting any changes).

I switched to `command -v bpftool` for now, is there any gotcha with
that one as well?

>
> > +     if (status !=3D 0) {
> > +             fprintf(stderr, "bpftool is not available, can't print pr=
ogram dump\n");
> > +             return;
> > +     }
>
> [...]
>
> > @@ -1630,8 +1678,13 @@ static int process_prog(const char *filename, st=
ruct bpf_object *obj, struct bpf
> >
> >       memset(&info, 0, info_len);
> >       fd =3D bpf_program__fd(prog);
> > -     if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> > +     if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0) {
> >               stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> > +             if (env.dump_mode & DUMP_JITED)
> > +                     dump(info.id, DUMP_JITED, base_filename, prog_nam=
e);
> > +             if (env.dump_mode & DUMP_XLATED)
> > +                     dump(info.id, DUMP_XLATED, base_filename, prog_na=
me);
>
> Nit: if you do `./veristat --dump=3Djited iters.bpf.o` there would be an =
empty line
>      after dump for each program, but not for --dump=3Dxlated.
>

Yeah, bpftool's output isn't consistent. I just added an extra empty
line, that makes dump a bit more clean (and I didn't mind two empty
lines, whatever).

I was also finding it hard to notice where the dump for a given
program starts, so I reformatted header a bit. Overall, applied the
following changes and pushed to bpf-next, thanks for a useful feature!

diff --git a/tools/testing/selftests/bpf/veristat.c
b/tools/testing/selftests/bpf/veristat.c
index 85ae7f6fee90..e962f133250c 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1579,7 +1579,7 @@ static void dump(__u32 prog_id, enum dump_mode
mode, const char *file_name, cons
        FILE *fp;
        int status;

-       status =3D system("which bpftool > /dev/null 2>&1");
+       status =3D system("command -v bpftool > /dev/null 2>&1");
        if (status !=3D 0) {
                fprintf(stderr, "bpftool is not available, can't print
program dump\n");
                return;
@@ -1592,9 +1592,10 @@ static void dump(__u32 prog_id, enum dump_mode
mode, const char *file_name, cons
                return;
        }

-       printf("%s/%s DUMP %s:\n", file_name, prog_name, mode =3D=3D
DUMP_JITED ? "JITED" : "XLATED");
+       printf("DUMP (%s) %s/%s:\n", mode =3D=3D DUMP_JITED ? "JITED" :
"XLATED", file_name, prog_name);
        while (fgets(buf, sizeof(buf), fp))
                fputs(buf, stdout);
+       fprintf(stdout, "\n");

        if (ferror(fp))
                fprintf(stderr, "Failed to dump BPF prog with error:
%d\n", errno);


> > +     }
> >
> >       parse_verif_log(buf, buf_sz, stats);
> >


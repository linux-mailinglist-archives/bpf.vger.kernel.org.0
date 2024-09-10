Return-Path: <bpf+bounces-39407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05937972A63
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7056C28620D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D417C22B;
	Tue, 10 Sep 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU+uwxiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1359BA45;
	Tue, 10 Sep 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952634; cv=none; b=ca/fPGX/PtcTkbL228abkU90HXhFPoE562Z74gnvQZy7KWEKpjJ83rOaRPVjR/UYr45RcjqTx6bUXgpIwrV+VxJ2w+ksVX8+g+rCf1Zq+0jvogbZ1DNBdCJrWh808yRoO6ACo5LSyBrA73sbVmjp1IhKZ9AqhxuiL1xnt0HSsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952634; c=relaxed/simple;
	bh=p59Ss6VtrKpvbydD51f2XLHA6rxcKBxjCY60kv3T+D8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlE+vKomu3RGhQiW6zuUvzJ1urUaLQn1ayYCpMo7rXM3NL4I/OjBpdIWo0wODAyZdOMdHDMs4wyNUZ7Z29f7eX+Wr/QWkMfe8MxuV0fz4ndUok4j6Ve0s62SFfKLlOzLBoDDc2vfZibK+Wj8TTmWpBa1WvIxpKl9FGV9ca9I16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU+uwxiU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3787f30d892so3113522f8f.0;
        Tue, 10 Sep 2024 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725952631; x=1726557431; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wk5p0AaosOp3QnIYyh9WhfdmB+ZMEKWe8kuMctYctKg=;
        b=WU+uwxiU0AhE6vJ+Ty8/vH8X4matMvi/SiDH94LdOQPyGos/MrZv1Ci2hthGNtBQ+b
         vcOOuDhNLKN/c5zMqpb30qnP+6s5ZXSc+LNCZJnbn56qqK6GYlkCM39j3u0omBSL7kRh
         8BK+C5DifCQ/AvWk2VgO1PpZQtG9Gyfvla2iyzhs5B28vhfSNQ5ie0G9BtF/FSl+Ymbp
         kf8AAl9IcnrMUKDPUCQ+0KT4ez8K8dgMio5vaqO2jHfbCNmkE2Uetef813P+9VsCaFt2
         dUrgR67pDQdu9uEZtQSAUOaScH5fr70Hd7Qa9bQwnVVSmfY6ALgp4GuxEYJvA/lShmKh
         WNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952631; x=1726557431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk5p0AaosOp3QnIYyh9WhfdmB+ZMEKWe8kuMctYctKg=;
        b=JhbkCtWRsxblbIlhCcdgc44tZn5DS1KlUvcbMvjvdnsM3dzVNZVvJqssueit/b7jTw
         0uyUlXLebPdILhdG1hg1L3yoa2SCDKpmEjKrOZYyzIZ6+SiTpnPOQDG5H7QDAw9/WIEw
         9wY38FwZIraBVO8+09pu4H2tHERqGbNXRtPDuU6mmB6DdUycZ2ucnJ+eR3jPPQUk7DRF
         tFNxB0zM+/33myOgpzuIPxp5COPFrUZaAIGIRb9axZSGraTYpfKg5EWy1WzChrUEWWbx
         /PGR6qMc+2qmMiF7CUsJ9HS1L71QfF9GMpotzKnzH199r8oFNylvT5XNBbFXkQ7zNkLk
         tCtg==
X-Forwarded-Encrypted: i=1; AJvYcCUCcAFTJ0CyAdHUxXNJAjTKrurdP5MxGJWHQNA3VSXlVnJOjBl8DTIU/HJHMe/ktzPKOA+bekEoKEXj2+jo@vger.kernel.org, AJvYcCWhkGTO3+efejyGiIZ5g7NwPmoWM7GKiYeiOCQgMfTNgJKzwI7P4VP4EnTFAA/opbXHOEY=@vger.kernel.org, AJvYcCWwjvYImY5IBf1R2EpCefwRbjZNOcbisncJa+mBq0vKIBX3S/HK2Cpflu6kl/4tfrnvZk26rGTE8FbikMuWKy+y0p7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjX5j9aOrsezLRZ/MDWfeSRinERhia3b4pKdHvq0IH5UO22xF
	dhexYc8F7CsvRnNHgIHXl+UmlowK+FPJds5LQxqHWJjxs0ncO2a9
X-Google-Smtp-Source: AGHT+IGwAKlJ0tPbumQP9ijb2hqxRTKEIzjuK5U9pKYKx7TpB3hM83iW8io9mcahSYP/cieSCof6jQ==
X-Received: by 2002:a5d:6a0e:0:b0:371:8dbf:8c1b with SMTP id ffacd0b85a97d-378895e9015mr8775342f8f.34.1725952630550;
        Tue, 10 Sep 2024 00:17:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8182dsm101648745e9.36.2024.09.10.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:17:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Sep 2024 09:17:08 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 5/7] selftests/bpf: Add uprobe session test
Message-ID: <Zt_ydMfrfNipE7py@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-6-jolsa@kernel.org>
 <CAEf4BzZQA4Sy+7mWzCM1zeWCZh8PM3OQqoLAMPWd+4dA4D=KoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZQA4Sy+7mWzCM1zeWCZh8PM3OQqoLAMPWd+4dA4D=KoA@mail.gmail.com>

On Mon, Sep 09, 2024 at 04:45:35PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 12:47 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe session test and testing that the entry program
> > return value controls execution of the return probe program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 47 ++++++++++++
> >  .../bpf/progs/uprobe_multi_session.c          | 71 +++++++++++++++++++
> >  2 files changed, 118 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
> >
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> (also note Stanislav's change of email, please don't cc his old email)

yea sorry about that, will change

thanks,
jirka


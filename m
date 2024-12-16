Return-Path: <bpf+bounces-47026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9539F2B47
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC591886240
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0503B1FFC7E;
	Mon, 16 Dec 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpXI+CWd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E01FF7A0;
	Mon, 16 Dec 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335920; cv=none; b=Ca9tObmdkGXmUVKqNba4knYd2tzzd8j9ixPKj2zt5u4Q26rD7lbqABDcBwhTH8EsS+tQ+0ijXmem9VRiPD4SXGrwGcHMnbQMn6jFztofnWjWu0XiW+pBUSAjuffRUKmg6vSa6M81C+SweWxKEyWhtuv3WLJzC8W1cJt6lulRKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335920; c=relaxed/simple;
	bh=xxP4Z5o9HC+CaQkoHHMM/63ysOrKemXE9vQLBvlDMwE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk9jz83XxY/Hc7QrSPv0M+mQF4ICysiZmpeI7vI0Jm9Z5T19Ewxjc0PY7Xo84IiNijwJsLb2TYjklDXOrrLqDjF9P6De/o+C8oClQ8Y+p7yk8g4o3Xud60hw9jPpSi2Oa/0ok4yyVpsWhn4pi/9xu+1wcv6ErqffpXBbk2dYVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpXI+CWd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so41742585e9.0;
        Sun, 15 Dec 2024 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734335917; x=1734940717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHQDsilWcBWo2qLCl2rPtBaAp/SgERxJlUjllIz41wE=;
        b=RpXI+CWdkCXznmhbK0cW94thH4nBu+iHSFeuSQ40XWOTtCgiv1oV0MI8wReY0jmV19
         ylY/RQm1DhLJhrX3Jf4DZuHaiToRMXwySF5W3y/Rnp/h0+/MAXcz9tf2ucnaKJ/Zp/+D
         hmus/B3jJQg4igSndQQ/Zkva4zkH5+LxJQv3bkFjHCifATCQLYkcwFQ9DqyTpiLcwc6U
         5wWW/qTZHlES5c5Qk1a7t9ITgFf8dKJnzkFHIHhMXTJ3L7XKF3hHv1XW0v8hWmYvo79c
         qcfsdbaVW8uXXtgqcYAw+pqH+jn2i9h8IY69zVCy5JXzLwuDj+TPim/QFbfBv+o4xPn/
         7SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734335917; x=1734940717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHQDsilWcBWo2qLCl2rPtBaAp/SgERxJlUjllIz41wE=;
        b=W/K7r+803gxd2/3zHQexDUAMPHmIPofVE38VF9tV/KRqBCDqfrp+igFrgj9+rNhjEO
         TKcWwy4aR7es6+Ro32kligrd/LBFWhiqKIfnlZNJ8vQtNM77lYi3nVZPMnlHiVDA3QzQ
         nzaHWRbOfTG7OtwEafG7AL7jbcL7ZuPkSyEiw8Bq43e+F25fz+TJ9gHqACUzDjAazPvp
         sJxnHUyIdLMVlLxbLtBn6aRWNcEk9f/6/LTXq5zIQ+YEaTlhaXuVW1I3q5nb0azGCr+J
         ca0P0TQbsFrlDZfeikKjZEiG/5b3zBs22uVkyVcwMNOG9mzVquDUqbPWbRRcEIH2ptHs
         dqMA==
X-Forwarded-Encrypted: i=1; AJvYcCWKSaDXr8AkR7YsLgj4XUx3NPAjrefK/SBaqEeRNz3dvyqt0gF9Cz3jl2BsXkDvHj/oQoC3jDgQUNEVfaCldtHae7t2@vger.kernel.org, AJvYcCXPL4X/cePqYGJInQHdCSdWhDQmMe82XpmOnqacOr0rICnas4c5Pxm5uSDJ0aIj07P4SZA=@vger.kernel.org, AJvYcCXoXL1rOOwbfujoNWzBXJGrf0Xh23tl8Mu6ZU3RdqES13wKqQQX6n5cZnVlmDaiJZOT54WkOpsZ8u6Ph4q+@vger.kernel.org
X-Gm-Message-State: AOJu0YxScFR98Yda/08OFoHs20fLWNIByIqzkRecHZkCa9ZvjL/sv+pX
	HIzclvBRVKj6xzObhx4lRWVJFkoedOcak4mVrLYwJeePz8E27R6I
X-Gm-Gg: ASbGncvSE1eCkLSroq2IrEl1vcDRs05BE60jNCbm89jluaOS7xW5NepPWG68t3RYgjV
	NhxtyGu4R3dB0UBoQkxxDTinKpiS7VlysoUm7jyOsxWWKFWWD+VDN1Q2FmhgCvhdspFxbr3wRIb
	gv1dbLSxezXjzHVtg7+SuOHgnuqwXMvlZzuNWBWBAUnsQmRxlbP8AVbeI2sIkySA83Gl7mZygbJ
	shv+4PzAtCXGWJEi1zsGoc2UrJ5ICvIInzM7DpanHOgJXw+qyiraYN6SPLyB1cUCuHdNdcLtvYa
	31NAAh3eKPZL6N5/FNLzIUS2utfVag==
X-Google-Smtp-Source: AGHT+IG/4I2JC5fgqyp/23EduntPTpbxZSHFCoLpI3oPiFb4SWfRzjunZM36hG2rKeMElQCUWNQCZA==
X-Received: by 2002:a05:600c:3503:b0:434:ff25:19a0 with SMTP id 5b1f17b1804b1-4362aa94379mr96018225e9.21.1734335916924;
        Sun, 15 Dec 2024 23:58:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706588sm134755195e9.29.2024.12.15.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:58:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 08:58:34 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 10/13] selftests/bpf: Add uprobe/usdt optimized
 test
Message-ID: <Z1_dqhXexpBz3oYB@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-11-jolsa@kernel.org>
 <CAEf4BzY=MOmqsuuL3iOyeaVGd63-6wdo9uU+6QhjbUOvgp=iVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY=MOmqsuuL3iOyeaVGd63-6wdo9uU+6QhjbUOvgp=iVA@mail.gmail.com>

On Fri, Dec 13, 2024 at 01:58:38PM -0800, Andrii Nakryiko wrote:

SNIP

> > +static int find_uprobes_trampoline(void **start, void **end)
> > +{
> > +       char line[128];
> > +       int ret = -1;
> > +       FILE *maps;
> > +
> > +       maps = fopen("/proc/self/maps", "r");
> > +       if (!maps) {
> > +               fprintf(stderr, "cannot open maps\n");
> > +               return -1;
> > +       }
> > +
> > +       while (fgets(line, sizeof(line), maps)) {
> > +               int m = -1;
> > +
> > +               /* We care only about private r-x mappings. */
> > +               if (sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n", start, end, &m) != 2)
> > +                       continue;
> > +               if (m < 0)
> > +                       continue;
> > +               if (!strncmp(&line[m], TRAMP, sizeof(TRAMP)-1)) {
> > +                       ret = 0;
> > +                       break;
> > +               }
> > +       }
> 
> you could have used PROCMAP_QUERY ;)

true ;-) will check on that in new version

thanks,
jirka

> 
> > +
> > +       fclose(maps);
> > +       return ret;
> > +}
> > +
> 
> [...]


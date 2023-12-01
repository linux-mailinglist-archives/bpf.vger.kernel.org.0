Return-Path: <bpf+bounces-16386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52757800DBD
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B10B21469
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9239D3FE20;
	Fri,  1 Dec 2023 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQAySGvu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591D1717
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 06:52:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a02ba1f500fso333900966b.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442346; x=1702047146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4U9gUs4NepFjXFwsIXGj7p59LuX4HiL4KpczytFXBGA=;
        b=AQAySGvuT7Q/0/SQ3wu297RaXsKpX9/6MD3N1xkU0BqJHHdW7AtcINrmpsMQ3JKwpH
         8VIM5hP6CcUIPq9v37X0OUZ5ZsA0+49JlE0I5TTPP5pdg3R3WyIWdBLosfoGe6RAV8f/
         qxnhWGPBnl053go5eMiLQX+JiU/0y8x77MwwlWRj6zSwxBYd3o0ogZAMt+CZRqnZpgeH
         +XXYbfA6pYt/9mkdLl3UdPWW+yfPxABTGGu665KtKt4GsBM9DmTNpIQU9GeQvRYoQU8m
         hXy0oYA4+bgVYEXzbmo5I4wXh0npgCiQnyrwWRNibOs7XEMpgp/ruUS6sphsw/1SQrCO
         QkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442346; x=1702047146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U9gUs4NepFjXFwsIXGj7p59LuX4HiL4KpczytFXBGA=;
        b=LCMXAGKkx6eSImcB5nKBhzTjDtdSZNCbR9GbMqLEqxAPwAzUaEJp4GCsWYihzPGeI0
         cJEEHB/ORURocUprRD/tnI03Rnn1Tp7gdQ58+tF1hqSvn9m+3AimQLD4LoQusSh092Tb
         aenPEssAsezdglr+Sx13YDidaJri92rvLODBEOVN4Qta4bvYlu1upP5rlG2rll2IZKsD
         jCw0Et3HIt+JFL8CvHKi3KCaAPtK5LlM7zNXYPa0NR1x4P5LWwC2DcPpU063LA+oOXPv
         2DaZp2Qz+zL/ch3yZkWyMU7Yy6OBfn9cFOZBaeJlvKOA0mhPQwt6HCRrEi1tveEQefkN
         0D2w==
X-Gm-Message-State: AOJu0YzI+0Z5+W9XewYiqQEK0HlqFyO8JE/RAwyaYEmQXq7/W7T6CLJN
	5a8IBTYGI8aTLaInd0/90+c=
X-Google-Smtp-Source: AGHT+IH76EfXAUX6eskmyE9ubnBR1zqbQd22xbKwuyvWUAff76a13g3aXuS6dHXrwJK/2apVjgaaqg==
X-Received: by 2002:a17:906:488c:b0:9df:bc8d:fbc8 with SMTP id v12-20020a170906488c00b009dfbc8dfbc8mr1028348ejq.37.1701442345419;
        Fri, 01 Dec 2023 06:52:25 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906050a00b00a0ac350fd57sm1975362eja.86.2023.12.01.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:52:24 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Dec 2023 15:52:22 +0100
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, dan.carpenter@linaro.org
Subject: Re: [PATCH bpf-next v4 3/3] bpf, selftest/bpf: Fix re-attachment
 branch in bpf_tracing_prog_attach
Message-ID: <ZWnzJjne5oMuEHrA@krava>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-4-9erthalion6@gmail.com>
 <ZWim7zRLA-cgVQpr@krava>
 <ZWkNBR-1RF8r4deG@krava>
 <20231201142143.i66qvk262a7zqg2h@erthalion>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201142143.i66qvk262a7zqg2h@erthalion>

On Fri, Dec 01, 2023 at 03:21:43PM +0100, Dmitry Dolgov wrote:
> > On Thu, Nov 30, 2023 at 11:30:29PM +0100, Jiri Olsa wrote:
> > AFAICS we can't do anything here, because program was loaded for tgt_prog but we
> > have no way to find out which one.. so return -EINVAL, like in the patch below
> 
> Yep, makes sense. Is that fine if I include this patch into the series
> with you as an author, with signed-off and everything?

sure, thanks

jirka


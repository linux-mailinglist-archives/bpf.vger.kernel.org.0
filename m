Return-Path: <bpf+bounces-15942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DF7FA526
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 16:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA690B20FD1
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40534570;
	Mon, 27 Nov 2023 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wQxhADxJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB62194
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 07:49:01 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cece20f006so22264327b3.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701100141; x=1701704941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OZ/zaPHTOHquaBYH+lbkY1d97Oatm6ySFdaXiL8Dhc=;
        b=wQxhADxJ3YePrynaIdGX6XyhjcqrN5oAYHmr0uiWS18I1PmgQXT/oMzrQIJYIqKkd4
         4M76Oh1Bsn5n9a71RJzdsQcDUE6dLYQtJS5NZuYgit/q6zR6GDHKkF3F3evJ/+tc1Bo8
         5bduubZaE2q2IFMsQbzElbeb3iKv+1xbIqZi1Leobv/x//EP1ksADJfgohudy47E8XHj
         bRsDIb6ha16k3gRjBz/jpEIEMQhCIqU/L3jDZAZOPLQBhWUXI+hV6xMvedO7Njq3nY1j
         QK1t4a6Is06m1uI0EUcPdrQss5Mp7BsBk/tPCdlFeFArMXdi3mNYLV7Yi3nGWzBeajWm
         kIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100141; x=1701704941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OZ/zaPHTOHquaBYH+lbkY1d97Oatm6ySFdaXiL8Dhc=;
        b=iwKohUSMYSIV09kjrVqSJ3Uq6qlSXBRkjQi0wUk/Q+KNrbNkp0wQ/FK5QHlhDA8U+x
         jB4Zkyf/wfucz9u3N/9manHOtMrg6jd8OutiGSR1WsrCuNpFD1KDerdxufNncbub7b0A
         7utmL0x34iLVxg93CeDAeTHTiqcBypJ3VC7ZJX/4XOfWRMrsXPXEbEcdt12GZqixDcqn
         IXbYHNiBLMppTgvyXhn+8fXIvq73F28C0iaSkdHjjMgg28HtNSZwRFgd1Vh3KUKHqgmN
         jJm8mKLei1ncrCgEpmgni9CCaMibbtCHIV0Dk4wnk3BZPs8/Pyopc3jHhlCB5kjQC5gj
         Rv3w==
X-Gm-Message-State: AOJu0Yy4kZOihuYN2VTYghFaCvN7Q7MhiY8jAXnBsnSuWTfnCevohg1P
	b5V7wDhZJVI2+toxvc4+m5fSZKcLRFuIt1RfMNpuBw==
X-Google-Smtp-Source: AGHT+IFlXI+XiNqcLAO9Li2OL/ymYfkxPzPfv7uyjeBxX3DjN83glydtRLaPL6pFsqlmWBZulq3Mf1wcsj0hqhBji2o=
X-Received: by 2002:a81:5c05:0:b0:5ce:4dfb:bce8 with SMTP id
 q5-20020a815c05000000b005ce4dfbbce8mr11984339ywb.7.1701100140920; Mon, 27 Nov
 2023 07:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124154248.315470-1-pctammela@mojatatu.com>
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 27 Nov 2023 10:48:49 -0500
Message-ID: <CAM0EoMmcPw85tQCMkg6XiMA2B3b8bkLS2TVCvxC_jrwVcdNJVw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] selftests: tc-testing: updates and cleanups
 for tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:43=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> Address the recommendations from the previous series and cleanup some
> leftovers.
>
> Pedro Tammela (5):
>   selftests: tc-testing: remove buildebpf plugin
>   selftests: tc-testing: remove unnecessary time.sleep
>   selftests: tc-testing: prefix iproute2 functions with "ipr2"
>   selftests: tc-testing: cleanup on Ctrl-C
>   selftests: tc-testing: remove unused import
>
>  tools/testing/selftests/tc-testing/Makefile   |  29 +-------
>  tools/testing/selftests/tc-testing/README     |   2 -
>  .../testing/selftests/tc-testing/action-ebpf  | Bin 0 -> 856 bytes
>  .../tc-testing/plugin-lib/buildebpfPlugin.py  |  67 ------------------
>  .../tc-testing/plugin-lib/nsPlugin.py         |  20 +++---
>  .../tc-testing/tc-tests/actions/bpf.json      |  14 ++--
>  .../tc-testing/tc-tests/filters/bpf.json      |  10 ++-
>  tools/testing/selftests/tc-testing/tdc.py     |  11 ++-
>  tools/testing/selftests/tc-testing/tdc.sh     |   2 +-
>  9 files changed, 25 insertions(+), 130 deletions(-)
>  create mode 100644 tools/testing/selftests/tc-testing/action-ebpf
>  delete mode 100644 tools/testing/selftests/tc-testing/plugin-lib/buildeb=
pfPlugin.py

For the patch series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> --
> 2.40.1
>


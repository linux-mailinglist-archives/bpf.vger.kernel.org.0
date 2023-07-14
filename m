Return-Path: <bpf+bounces-5034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD3753EF3
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDC21C2132C
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36FC14AAA;
	Fri, 14 Jul 2023 15:34:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEE13715;
	Fri, 14 Jul 2023 15:34:34 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897EF1980;
	Fri, 14 Jul 2023 08:34:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b734aea34aso32529501fa.0;
        Fri, 14 Jul 2023 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689348872; x=1691940872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8uvHNk2u3IePlrVGerYCmip0Mv9HhoiBvdBWnQYaSc=;
        b=k+nK85u3EyT5mN7LjJbr3AIuoAx4OKHiV2MeSrxUbCLp/F400wdGQMMT0H5kCyXt0H
         43FYEuPP24DDD3EcggY/3iFHuRDq/QgFiaHb31WDplNabOx0m93OkD/wYPJv+wpVDSYQ
         Ldal++1O49jD6VzVaN5twgiUfNBU3XQKg4vYEZ86119Z566XIi57bUIrDVFThdMJMp0T
         YubySX7uKw37YvH71QmWDzgf5rGTUYsmu3g641zPoZu7LwZkV5jf75UiAkelT8UALvQr
         rIcNimHK881wnWo2/cOZvJVQRQGnA8ASJYT8pAGrsEmvP8XgQEBE6uW0791MMHCcsunt
         52bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348872; x=1691940872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8uvHNk2u3IePlrVGerYCmip0Mv9HhoiBvdBWnQYaSc=;
        b=dFlRTva2mfKi/PzIg461l5gW5UQPa68cGnttG+ut/aZNs8gqfP0rH+iA3a53asfp8k
         kftgMWK+NAS1XEZRqFhcJUhXW//HCFG6eOnDIoiXbfAVNy1Ivi/9r5wBmBx06xERnfNN
         FXrVxnPJ3toY4qLmKjJCYR/7MQX34jmbtVi0/fyt8olW7LXKZAmX/5+uxL5n8qQyLxzb
         Icos2prbheRKdGFWz50QtKoa2CRx4hiBrKqB3vQKrwHNaq2i/DaTMsUQhuv7Y4f3R0Mc
         4ZYYvTKdv3bOYDo6hOmdKznC7WLDmOrzVVKJ0SGbJYnnW9to6LswU9sYmaaw9Nkr9kc4
         nD8w==
X-Gm-Message-State: ABy/qLb5hpV2HFYnCOOEjvesxuaN+5/+9xvSC0Rt9IclacYZVQTEt6eU
	2NO2yPImQsU2BPzm7UG0JCKgwL+wuZL0RszKuw8=
X-Google-Smtp-Source: APBJJlGnSSaCsbYJsQNOjRVX77bpCr+vkJgPlJ964TQc3AOMDL5SjDwZ23XxSOKxygjqmvCv0kIEOOp7SZveApz8LVY=
X-Received: by 2002:a05:651c:d1:b0:2b6:fe75:b8f3 with SMTP id
 17-20020a05651c00d100b002b6fe75b8f3mr4234907ljr.29.1689348871370; Fri, 14 Jul
 2023 08:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jul 2023 08:34:19 -0700
Message-ID: <CAADnVQK=pMJ6XC_4YMEWGBq954L7B8mK_9N3Z4pQV429whKYjg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 00/24] xsk: multi-buffer support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 4:37=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> v5->v6:
> - update bpf_xdp_query_opts__last_field in patch 10 [Alexei]

It doesn't apply. Pls rebase.


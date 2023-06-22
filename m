Return-Path: <bpf+bounces-3122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EF739965
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D4C1C21031
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B231775A;
	Thu, 22 Jun 2023 08:24:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D1613A;
	Thu, 22 Jun 2023 08:24:31 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194C1BCD;
	Thu, 22 Jun 2023 01:24:30 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7576b53e75eso103136385a.1;
        Thu, 22 Jun 2023 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687422269; x=1690014269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnWwUiadM7UrLxznzV+MCTaz25u3pnczQbgkP5W3wrY=;
        b=lt370cX/SMfTLgkEsciPSNA6S833B2qFQjLMQZmWxwOxm2NEAsyKa9bNZspLfY3tTQ
         jqfjcIOEsqW6sdllYxAMEm7lVxRDFSavJfaNrW+ez1T5lRR9M1PRZwVlHd7V26bwFu1E
         u4uxvWObmUgPlRSS49exkhhEtFsU4mIYtBU5P5dZd6RGPW+LLl8/a0/hOwKG2uDeapBn
         JV7mB7rsIRkPBXT7c+wbB6LoN8j7WyeFsvTsJy4AKF/BWxTeC86KTF8RtuMBwh37oGX0
         k3O0+yhPzQUl3F63PXj6ojaX2W4VQ4b7S4cmJgMIvhlgEdU694oHrpLodZdWsAnxWnd+
         iR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422269; x=1690014269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnWwUiadM7UrLxznzV+MCTaz25u3pnczQbgkP5W3wrY=;
        b=CE37K/zU89PQqlV/x6qrbUkCchEgS3RjJDh+QrLlYH6BONQ2W7EgxhhTh1tGYi5/Xp
         HWgfkNlO/S2+vejKOlBQq1OjziuP5mZ+NrMBTQAFAyrWzvbrUWkkPOgu08bRW9UAJ5kb
         S+D3UsuADIkUsAPahYw3kocw94u0fp7v4quGRAjMIIVGfsx2SnynPAwy/VWiaJ6BEHIb
         6psdzT6dO5kxISGO6lmBSQQ8CmKcauHDWk+q1NNsUaNWAK85nIzgOTpnz8ST5impeFey
         tYOgb/WuMHco8n5hAgLKlI149yqJQ3+xK/fJunrVy8EWH2nfj1LOkFI+lMLGc3Mo4Sba
         S7Zw==
X-Gm-Message-State: AC+VfDyjh0ANvSJNC37GCwcjCtCEvdcQ7eYZRleQ/sQ9L4zKdI6l6oKN
	+BGtpfWzsCQcrnNnooHE61Ekkpas1OB0dOoUtZU=
X-Google-Smtp-Source: ACHHUZ5ijpIB8gl+txKFIazHjZl8PRRTBcZyBzRkMF0O/6QCG8BjxpRmyNq0a2R+EyWNPzxIFXsstWIMEih1G8E4XYc=
X-Received: by 2002:ad4:5de8:0:b0:621:65de:f60c with SMTP id
 jn8-20020ad45de8000000b0062165def60cmr21494288qvb.3.1687422269325; Thu, 22
 Jun 2023 01:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com> <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk> <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
In-Reply-To: <20230621133424.0294f2a3@kernel.org>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 22 Jun 2023 10:24:18 +0200
Message-ID: <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com, 
	simon.horman@corigine.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 21 Jun 2023 at 22:34, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 21 Jun 2023 16:15:32 +0200 Magnus Karlsson wrote:
> > > Hmm, okay, that sounds pretty tedious :P
> >
> > Indeed if you had to do it manually ;-). Do not think this max is
> > important though, see next answer.
>
> Can't we add max segs to Lorenzo's XDP info?
> include/uapi/linux/netdev.h

That should be straight forward. I am just reluctant to add a user
interface that might not be necessary.

Maciej, how about changing your patch #13 so that we do not add a flag
for zc_mb supported or not, but instead we add a flag that gives the
user the max number of frags supported in zc mode? A 1 returned would
mean that max 1 frag is supported, i.e. mb is not supported. Any
number >1 would mean that mb is supported in zc mode for this device
and the returned number is the max number of frags supported. This way
we would not have to add one more user interface solely for getting
the max number of frags supported. What do you think?


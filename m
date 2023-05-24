Return-Path: <bpf+bounces-1176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12870FC29
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797C62813EC
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476F19E72;
	Wed, 24 May 2023 17:04:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F56087C
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 17:04:57 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05A5FC
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 10:04:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so2536715a12.3
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684947894; x=1687539894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX7TwOTtxI9078iXGRe1v6WXZvE2EIyaYMEVVHOjuhQ=;
        b=QB74L0/jxXd7y6nW3o9xkHAJIGRnmghtu93J4jDvwNvITeAIoQ1Kd1rRdiYr0EsKlO
         +aIzASoolJ7V5hvYVZHGh+d1/19LfKg+NewxKOmVGDjN3vIpHFdFVLQt1Qluu2Rpm/3+
         aK0A+P4xTNZfXzKSq4eTMQ/cB3Tjxhif9bPIY00bqC8CLJS6c8BmMFPgpsLjOCk6gm3S
         YbtFgwOiKDh7RgQ5jbPAbs1P6nZNf4zntXtiORXMtYxAbsEKieiIoAZibgKcmbS2wjv1
         4zhipa+jS2pTh/jdOn/KCsGN/3lPwStUz3dDOJwPkipAeFah+0fTPiKkrFDGPvm/BHyl
         7Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947894; x=1687539894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX7TwOTtxI9078iXGRe1v6WXZvE2EIyaYMEVVHOjuhQ=;
        b=Ldq5PoJ1Mo8dGqm4t4ODpGb5LNfkE+3tiQgc5Ix7AcnI+m+Whoi8ax1mD9Zt9PP0aM
         cUCEKklZGZG19B46cT4vgZmB6PSnMgI3K/5ygvUFUW+UlN5+F8qnLB/9wl8y9mCFWJ5Z
         hB3qBKGsWUQ86uCm8NVqOIxgMYacQ/5OJkBoWdl8PIUMqEPqQaylV9+Te77NVd4sZ3Qf
         WgUeqWl1dQtD2VLuGte4auzbQoUSHuIMCBXnN7e4Ax6QqQLvMey5NBnHFubT9E/Pp4kG
         tA8AQZP9T24Nks6axh8ob7FxLawEjzN0lBiAmra1xLlga2o2oBUUraY5/yxeBax/t9pS
         Ioug==
X-Gm-Message-State: AC+VfDz1sd+Pnybq5txbop64b04BcUBqD5gahmgDWY/3k7KQg4PQU6nO
	RNIMMfV0vInE+xp4OantRe+6/kCKcQHFmleArO2GGQ==
X-Google-Smtp-Source: ACHHUZ4aecbcum+oSXCnZ+4TJGsowymNKbx5UWCjquYoSEqmkz10v6iOSfhb3hZe59JPC3irVPSk8/T05oYKdYrnw0g=
X-Received: by 2002:a17:907:8a10:b0:96a:d916:cb2f with SMTP id
 sc16-20020a1709078a1000b0096ad916cb2fmr19835435ejc.36.1684947894084; Wed, 24
 May 2023 10:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh> <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
 <2023052435-xbox-dislike-0ab2@gregkh>
In-Reply-To: <2023052435-xbox-dislike-0ab2@gregkh>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 24 May 2023 18:04:43 +0100
Message-ID: <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, 
	sdf@google.com, error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 5:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Great, any specific commits that fix this issue would be appreciated to
> be pointed at so we can apply them.

The problem was introduced by commit f4b8c0710ab6 ("selftests/bpf: Add
verifier test for release_reference()") in your tree. Seems like
fixup_map_ringbuf was introduced in upstream commit 4237e9f4a962
("selftests/bpf: Add verifier test for PTR_TO_MEM spill") but that
wasn't backported.

To restate my original question: how can we avoid breaking BPF
selftests? From personal experience this happens somewhat regularly.

Best
Lorenz


Return-Path: <bpf+bounces-10948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B927AFE48
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F32AA28386D
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877E1F619;
	Wed, 27 Sep 2023 08:26:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579E1CA8C
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 08:26:24 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5BCE5
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 01:26:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40535597f01so105442025e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695803181; x=1696407981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1S0sjCxK52kFrN3z+ntkDsyXc7f2ZSwIlH2uGcEEFHE=;
        b=MjsY1UFzCnFJiWbrLbCk2UnD2khBh+xGOewUJORQO60ObfQcxtdzSuHQPVNAIEEjKG
         JlPh40sKVA5WtENBVf9+U3//lLbDfcAUJBg5nHgYsjxtFTgWLACLGWSi72Ra5yFPOG72
         4wkIUxXGf8l3oFswbb4ybwgJazqOvDf3qXU7ht9FlFH1oVMhdPx8/AaeVuBeiROM99s0
         I4tpKJee2L7dvOgQpGqojxt0hY7ipF1lK5Kn8zKQdNIkoM/jZpWw0WZA7yHg85LBoNqi
         P0d0mXahCkcuc3uwN0E7X9hM6FqWwahzOnksAskwvywDDDmjWYOlCXwLfpP8NUkUJqkA
         McKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803181; x=1696407981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S0sjCxK52kFrN3z+ntkDsyXc7f2ZSwIlH2uGcEEFHE=;
        b=OqObF2O3mrO5QKlDz5fNEXZJDQPHWS/AY7Ho5eo7FjDxKiY8Q+etrhTLMtnC3Pby45
         8ZqZ8fkj65d1gXtcyxb1WiO0O0L64BMXgKOCZcEaWhaGGv78M22T/1ph9p+iGWVUJwRA
         vIK4CFhkiVBSZWsDL40lR3YX0NcDJ/WcnRQigUF4d8805ZsgL1mq/yE3KzIGjK8RyOQn
         VoUpKqrYKqCiVaCLeaHpK8qNvPXaD1qT8OlE5WYEkLWhX0X02+NWOhLgEy8pL0qJD9Fm
         C9EeEXBBKotM65pONMgY2+BZttoQfoc8FCg717hQJmBy8MjNdzqU6H1u/BH1DsP1lGX2
         lr+A==
X-Gm-Message-State: AOJu0YwxYyLBQA3dqVWVkwxfsvFoWGDD5msvjrryunH42wvvofiA+uU4
	KJZ+mR4QJPB6+1hWgnCQThI1Ew==
X-Google-Smtp-Source: AGHT+IE6zzb2I90mS1ReUzQUROs5Vrb8LrbuqA6E5BCLAn1zWS7ShZ/X8B6/pjNXctmhlNUYeodoyw==
X-Received: by 2002:a1c:4c1a:0:b0:405:315f:e681 with SMTP id z26-20020a1c4c1a000000b00405315fe681mr1298521wmf.40.1695803181286;
        Wed, 27 Sep 2023 01:26:21 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a08f:20ed:5155:605b? ([2a02:8011:e80c:0:a08f:20ed:5155:605b])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b00405ee9dc69esm4678136wmj.18.2023.09.27.01.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:26:21 -0700 (PDT)
Message-ID: <5fa2a6ed-49f0-4c10-a9b4-ddc08706f759@isovalent.com>
Date: Wed, 27 Sep 2023 09:26:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
 <20230926202753.1482200-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230926202753.1482200-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 21:27, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>



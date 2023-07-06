Return-Path: <bpf+bounces-4297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D718974A47F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57241C20DEB
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FCC153;
	Thu,  6 Jul 2023 19:43:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB91872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 19:43:20 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6671BD3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 12:43:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3142498c2e3so249835f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688672597; x=1691264597;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhm/jJrR1NHfK1pGN7EZo6eMVf2ZaHxU5UH60jdxSyw=;
        b=J7FPWLa6RpMlLOE5RwQYNk7L0ElaT87B3FFxGzrSTfNoLYbmh5D7OTsBd1JHcS3mWl
         qQFW19Yg6zo6RIsqFzjEI3yOOUPyulybQEVp2/4x8zka/caCLKTUXKxghUx87DaZDDJP
         tk8/cEVxgeityp8j/OrsFUoVt/xvKiuuOWzO60hb11C1uRYGK5b5ZjLine3roP8JAHKJ
         68xnFe8waQ9DgBgDZFueue+Sa3V7XDwr9ljNQuQvWjhB70msf6AFKdPUOupTeyQWRrRJ
         FrHrWSm2TwNQahuEajzeOXgUVBzNCFnv1Mb1UiQ8gOWkVXiYo2rUOZ9bAwBRcsDlgE2n
         smow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688672597; x=1691264597;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhm/jJrR1NHfK1pGN7EZo6eMVf2ZaHxU5UH60jdxSyw=;
        b=lVGMoiT1diJspen7uR6Y6JYBAEwghVfPPq3sKGNUqqwzv8rmbyV34wCeHj8ppYSb13
         g9NEyaOAUoSaY91FtFHchKs7BhcKICaEBPivWDSCgjYWBOIfXB6gdk0Dh7cEc8YkD+fI
         QaF/1duyLhpKxWRr4OotE3Q68CVEBXOsX8CdBGoAnwDJLzJyiZZpnihWUk6D6wR13q+x
         SjjQ7rux6Y7J0q+b3OPOW1N2Ma5MqgeT58MyjoNXoEheJ388/lxoDgM0YuwOY5GWp132
         G6WsakLv7LQH27YggR6s4ILmvP2mu1o8oSs3hAjtyWR0PaDM3kAm0OzreVGcEo0Kck5x
         q/Pw==
X-Gm-Message-State: ABy/qLZvKA1X2MC8OJ91s0Q5TpCD26BaB+wcCXUi/RG+a2EL+JibzXRy
	bYhBqHQndxTYxydBHGw7qWw=
X-Google-Smtp-Source: APBJJlEFW+Gf4pNbVCJS5ndRPmqxjCcienCUY7YNr8CRXubOimUzh/nbMUVzze0tUFBGlgW9yfhOhQ==
X-Received: by 2002:adf:e706:0:b0:313:df4b:414a with SMTP id c6-20020adfe706000000b00313df4b414amr2219200wrm.5.1688672597403;
        Thu, 06 Jul 2023 12:43:17 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.92.16])
        by smtp.gmail.com with ESMTPSA id d8-20020adff848000000b0031128382ed0sm2590580wrq.83.2023.07.06.12.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 12:43:17 -0700 (PDT)
Message-ID: <4e4a3024-0482-665c-212f-f0084f404239@gmail.com>
Date: Thu, 6 Jul 2023 23:43:15 +0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
Content-Language: en-US
To: Anh Tuan Phan <tuananhlfc@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, linux-kernel-mentees@lists.linuxfoundation.org
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06.07.2023 20:00, Anh Tuan Phan wrote:
> Update the Documentation to mention that some samples require pahole
> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---

Minor nit: you should write what changed since the first version of the 
patch here, otherwise the changes are pretty hard to follow.


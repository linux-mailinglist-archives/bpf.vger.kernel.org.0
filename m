Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86551927C7
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCYMG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 08:06:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36079 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCYMG0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so2356440wme.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+PuCayDB8/bzQ2bHokcpFfFt5a4I5BUuCsnOfLRNswc=;
        b=ZI4mEik3eoP0ROxeS3oL2y4mBlwTAhEpvjh3oaTAii4PXNjtOdoF9lCzTuSyJMFphy
         Ux+RApkQNzuPXAF/TiD94+U4PYyPIoftuvajAI7lHu5pDlMKTDhe050nwd9jSEpK4dUL
         nMpZjQPgZWp96mxdmgUOYnla/p0akCIya2ooavLXHgH9q5HxxAcMWgfC5x/DDVXxxhWN
         jwq+rLxVRLIPdlGifJhu2l3rkxzWqIDiEeoPMXnw7T/ItINrc0m6tRVrWKDMWZBlOK/4
         WwS2vRqffUulFoAnNjf9CKqIgird9ROKt2YJEXOe3ZNAe3BIUQ2Q6QeYzMxTYYtgbBea
         r5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PuCayDB8/bzQ2bHokcpFfFt5a4I5BUuCsnOfLRNswc=;
        b=KKaKmt6iHjDDyEBOLodz2pKnAv1yFIjvKz4Vkr51Ra4YKmL/KErreOX5GACXnvZP6I
         Pv4jjNw4jvdP1JEJNIn8yhcnJQIxUO6CGWADm2XN1pKZDk4d4oT9QQTs0USESWlHSFzf
         bc0t4MXOEYn5PJpAYfdwUj+CeDVWlat0xPoW+3JvLOMrv2Hk3yjWzshun9NRpg5E5UpW
         qwwXg/LSMPU0PtI5+eyh+/ElC+IaEcUzGujaWFdc55ZNoCg8dtNhJJ5XD3njHXK7VgVG
         TgY62/+x2PFbBXGXrBZny/Dmo6C0z0rwAmpBir/JnSMMpfVUyca5RLmhSaddA+xCu21y
         D6Xg==
X-Gm-Message-State: ANhLgQ37XkUZB9qZ0izGCZbOS1NhZsRM0sXw88QgV/7aa/CP1lFzrp0L
        CKhgaTkn7T1DL//1rYk0VnfH4m30yP3xVQ==
X-Google-Smtp-Source: ADFU+vuouDLwROO6z7rhU4N4JneKtsKaMBeVQy9BlXcvDLkHxBIcGJSMOErhyX1+DBkhC4/kvS0+jw==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr3297274wmd.55.1585137984044;
        Wed, 25 Mar 2020 05:06:24 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.40])
        by smtp.gmail.com with ESMTPSA id k9sm34983203wrd.74.2020.03.25.05.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 05:06:23 -0700 (PDT)
Subject: Re: [PATCH] libbpf: remove unused parameter `def` to
 get_map_field_int
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200325113655.19341-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <8ef9f1d0-a373-c15c-954a-3e29354de173@isovalent.com>
Date:   Wed, 25 Mar 2020 12:06:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325113655.19341-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-25 12:36 UTC+0100 ~ Tobias Klauser <tklauser@distanz.ch>
> Has been unused since commit ef99b02b23ef ("libbpf: capture value in BTF
> type info for BTF-defined map defs").
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>


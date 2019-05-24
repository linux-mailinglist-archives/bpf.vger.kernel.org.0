Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786C529F5A
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfEXTtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 15:49:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40489 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfEXTtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 15:49:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so10279400wmg.5
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EfzrOSL6BVqiSM/a8+/TRo2VDaFC4vu+8iZJ/oCCQW8=;
        b=H+jjTyI7YjmvnJjPFC3Vx0UEph67Z3FRA92MLLGd0GbOoJyNlvtRzTL0RxVT+3uex4
         OPnOtV/KXPke3Jh8bJCXHvxlC+uYFDmoW8oDNyjEraDd8x6Xcs6gMn9mbmcpaJ8igaE9
         r3tDkJQbN4c+bATOAX9flvT67QrvWh+jGUDSeNDDO0H7OhWZM1E7WKblHzjKpgbS977s
         yTvBQ8FVX1qy+34I104AkGoszzYlnVEp8diVj8c/sahsUzNOW2+N7tjLGVdTCsyn79xP
         t7vwa+3/SRxATiTtsj5YHUec1s8Hr+A5IFupyUT983Bdl/0LneUCQLv6x/ta5EBN8hcl
         BSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EfzrOSL6BVqiSM/a8+/TRo2VDaFC4vu+8iZJ/oCCQW8=;
        b=NFADZnYpVc7xVUF+sfF/tPHyFQMpYk0locLpf0iOH4hfwXy1P3QmTqozS7l6RffXml
         ylC3zD73U+5U8gyghi6OV71OCrKw/ThtRiOYOy1MdJOp46JuI5igLEQpL4InssDtyQiq
         6vVQQYZJ6T1pYgjRfrWqBG96jmdNrtbqaTwZOsFZ0eMvIiZ7xIITOZ1Mdgrjq2p1cQhh
         D7S+Zz4loINHBrrqX1MYM2hoP4W1UgZCnR8gKRtbaFx7+supQjjeqi4RpP5kzbLtH+bq
         ww/kb6RyYBvvyelfVFO8DWt+uMfdNdHEgEde76dv1MTn8KKPsYfHJvXefF4+T0IUKegb
         c75Q==
X-Gm-Message-State: APjAAAVJMu9QMia1wQok720UjkF/WZpjuunzDR5yWjzElxMg/4H3s6tr
        7A+F/ZCS52UN0EaLWKrjjZCY7w==
X-Google-Smtp-Source: APXvYqw27HQ48VgLNcgxtiLVchDR0pRvMv44DVLBvk21TR/gj+lVNDHzAkIysMHJrQnKLss0zCRDPA==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr1157493wmc.90.1558727343345;
        Fri, 24 May 2019 12:49:03 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id u11sm3524376wrn.1.2019.05.24.12.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:49:02 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 10/12] bpftool: add C output format option to
 btf dump subcommand
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        ast@fb.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20190524185908.3562231-1-andriin@fb.com>
 <20190524185908.3562231-11-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <4d7cd84c-9e6c-c13c-3549-c490407ee615@netronome.com>
Date:   Fri, 24 May 2019 20:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524185908.3562231-11-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 11:59 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Utilize new libbpf's btf_dump API to emit BTF as a C definitions.
> 
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Thanks for the changes!

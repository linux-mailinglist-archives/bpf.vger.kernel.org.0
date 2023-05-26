Return-Path: <bpf+bounces-1291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C1712074
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 08:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B293E2812A7
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED55662;
	Fri, 26 May 2023 06:51:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA420E6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 06:51:03 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181C2BC;
	Thu, 25 May 2023 23:51:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2537a79b9acso420824a91.3;
        Thu, 25 May 2023 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685083860; x=1687675860;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGACEaIrD4zSU2aeog6vBy9O4EkGvsfRbD7VCzWE690=;
        b=QquRqePAsyWnNBwrIyycy3XucFj/jFX/3GNN6UTB+K06ZMnraSlxYSIsUJqKy5XMUd
         J5hOsxE7YqPwO/xalKKueQzNJuGql8Dnq0oTSb5kpGDmzLN50pDNm8spjEBA39Rb4tV6
         JysGZTJZGJLKv1k83I5Z2XD6Mp8pmbkBeYdOd6/cqm/YK+ZCD9B4BBFfo/41ud7N66Bu
         Py5RuCd9N/g4jlFQlHmQrdMX2ROZx7oJSjagyDR919/H/oAnOriRT9RwDoGIBOW6aarB
         iHQxxWIbd21jAePa+Fjsn1j6IfFK+31c77Bo/ViYDVBnwAQcOGQPVMXe/kp32aJJESla
         OrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685083860; x=1687675860;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGACEaIrD4zSU2aeog6vBy9O4EkGvsfRbD7VCzWE690=;
        b=cF6qhKmm/odQAjhq/QyjVBMgZUh27y7xt5JJ4v1DekToF4pC9BDSxiG2Jo+o+R9IdN
         gbrepgE5UV/mtkYnwcBmb6nK2XnOwHJbi8E+fmVjhQ0tu1M40VsjvoOQJFNEdxzhZ5LF
         C962txf+gYWxUalsfluvz5Fd4Ge4WtwFlblI4XV0L9f/zH0rldqXhNl5kT+H6W2Rv+u1
         UlcQJlFCx+ZADhb5GfUny7FX7oVwISebgq3KSTPObLeS2rTIpL7hh5GGy4AlHSD8HYxm
         aCD39wQaq5aDo/L62AOQ3DNk6zO9aCEEXtDafTVep2orHfc758z0lIxidoAPkLnqaZI5
         aE6A==
X-Gm-Message-State: AC+VfDxJ7jH0xsMl0rmrimh8mI1qgaqA4jzWLuQh/W/8YZMRwWif/L9q
	dh57CGoyy/u2wr/JdJ1HdKc=
X-Google-Smtp-Source: ACHHUZ4DEG7JENscgMVffBweyP9OhNGu3BglBG5gmEAogCCfXi1Wr8JvIrH889GSyjko8GKa8lgjYA==
X-Received: by 2002:a17:90a:7106:b0:255:dd84:8643 with SMTP id h6-20020a17090a710600b00255dd848643mr1810477pjk.8.1685083860490;
        Thu, 25 May 2023 23:51:00 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:17de:b2c5:b0ad:62a7])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a3d4200b0024e227828a9sm4259536pjf.24.2023.05.25.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 23:51:00 -0700 (PDT)
Date: Thu, 25 May 2023 23:50:58 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: kongweibin <kongweibin2@huawei.com>, 
 daniel@iogearbox.net
Cc: andrii@kernel.org, 
 ast@kernel.org, 
 bpf@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 hsinweih@uci.edu, 
 jakub@cloudflare.com, 
 john.fastabend@gmail.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 liuxin350@huawei.com, 
 yanan@huawei.com, 
 wuchangye@huawei.com, 
 xiesongyang@huawei.com, 
 kongweibin2@huawei.com, 
 zhangmingyi5@huawei.com
Message-ID: <647056d28d59a_2023020887@john.notmuch>
In-Reply-To: <20230525143814.361127-1-kongweibin2@huawei.com>
References: <20230525143814.361127-1-kongweibin2@huawei.com>
Subject: RE: [bpf?] [net?] Questions about the impact of ebpf
 sockmap/redirection on socket performance improvement
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kongweibin wrote:
> I'm using ebpf sockmap/redirection to bypass the TCP/IP stack to improve
> socket communication performance (throughput, latency) between different
> PODs on the same machine. As concurrent connections or payloads increase,
> there may be unconspicuous performance improvement or even performance
> degradation compared to the TCP/IP stack. I have retrieved some performance
> data, but it does not seem to involve high concurrency and high payloads,
> I would like to know if community have conducted relevant tests on these
> scenarios and have any opinions on the poor performance improvement in these
> scenarios.

Not fully following above, what is your performance test/tools and what
were the numbers?


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDB755498F
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 14:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352469AbiFVIyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355528AbiFVIy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 04:54:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A733E95;
        Wed, 22 Jun 2022 01:54:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n1so22139727wrg.12;
        Wed, 22 Jun 2022 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSnTuKyAEQznMOKio5DJTSS6Ar+VbuhbWZFcTUrdno0=;
        b=kQxE01iQo67i7D7weXgdN2OAzpYTszypFwo7OSDINe53zPxhw5gNX6Xp/3pjD2z2U0
         C8oDVtga14pstgNMbkx7DNsXGducbRp+rbgVQ769sFyWdtG6xVoolN9I87vqGo7s+2mA
         JiBzJXsOA7uyMlLjsPSvqboiYP64j46eJAT4zu+uDNBzU6QU8+lUxelYBqyS8z4posWX
         d4Gg+z3UGPwX2wNOc0j08EUKJkM4Z8a6pkUukPrjhlYmbhD+6PnSvqKI8dVt3rURuD1Z
         diK6bm8GJ/Z7kbAQ27Y/qRH4LiaYoysaaU7SwxfAyFt0waCljoAsLkcoH1n+7ocDbvid
         Mcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSnTuKyAEQznMOKio5DJTSS6Ar+VbuhbWZFcTUrdno0=;
        b=KJucKNziQOLfKeqf/cmDxqJO8IIrVmj+oCgaOPYxE8P1q9i8Y6jQwhjf7QtHgXRaF+
         T3dhlBuLj+5A9d9a+JIQsnmcBa2X1q5fQBod+GZkw6A+AF6ojya3zlRPYfSmNgHnJMgA
         zYPdEr7OAsSsVXaznRv8RRKEA5LJ09nTHNck+U9Fy72M8TmgI8sFUfOdYiPQOovYx4K8
         nT1AyoMYkKGd/+dbtuNyIwUDx2YA31LvseqELc3r8W21gKyYRg1+EZe8CiaNK16ye6tK
         sYiUOO5oZyIPYogsCmyeIuYxiudTqf6eyCBaqOn9BuZSn9MnO6/WBpKnIB9AoFQRSbZ3
         Pasw==
X-Gm-Message-State: AJIora8HJcCAi6B6IANzHRHgfQsoTgazE1x+EKtTUzW+QINJDQ9DBqNj
        IxTaxYZ/coR9CYD9Y5ZUolJL5QGuuW3iMw==
X-Google-Smtp-Source: AGRyM1tn+kK6+v7DTfaND8NnETGmYc84yT2z8QjXz1XX6/5JmCJE8rhuxZm4l0FA9ZUu+13OebayfQ==
X-Received: by 2002:adf:fdca:0:b0:21b:8e8e:686e with SMTP id i10-20020adffdca000000b0021b8e8e686emr2200982wrs.368.1655888063459;
        Wed, 22 Jun 2022 01:54:23 -0700 (PDT)
Received: from ddolgov.remote.csb (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d67c3000000b0021b8cd8a068sm9511209wrw.49.2022.06.22.01.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:54:22 -0700 (PDT)
Date:   Wed, 22 Jun 2022 10:54:21 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220622085421.k2kikjndluxfmf7q@ddolgov.remote.csb>
References: <20220615211559.7856-1-9erthalion6@gmail.com>
 <20220619013137.6d10a232246be482a5c0db82@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619013137.6d10a232246be482a5c0db82@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sun, Jun 19, 2022 at 01:31:37AM +0900, Masami Hiramatsu wrote:
> On Wed, 15 Jun 2022 23:15:59 +0200
> Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> > From: Song Liu <songliubraving@fb.com>
> >
> > Enable specifying maxactive for fd based kretprobe. This will be useful
> > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
>
> I'm not sure what environment you are considering to use this
> feature, but is 4095 enough, and are you really need to specify
> the maxactive by linear digit?
> I mean you may need the logarithm of maxactive? In this case, you
> only need 4 bits for 2 - 65546 (1 = 2^0 will be used for the default
> value).

From what I see it's capped by KRETPROBE_MAXACTIVE_MAX anyway, which
value is 4096. Do I miss something, is it possible to use maxactive with
larger values down the line?

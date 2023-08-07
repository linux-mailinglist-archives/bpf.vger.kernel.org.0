Return-Path: <bpf+bounces-7178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A67729FB
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60BA1C20B94
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABF11C88;
	Mon,  7 Aug 2023 16:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9311196
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 16:00:12 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF00E79
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:00:07 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63cf57c79b5so30421676d6.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 09:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424007; x=1692028807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJ22WYEke/+FRZ158MaUEXhW/xNAw3oVqqtmb4BpNvA=;
        b=Bx4sO7FH2IYKAuaYEs7slgwN1l+rfwdrlmaY7u2wdM7MfrduiJrqhnGg4J8NE3R+Ni
         QPFtkLpDr+NgKb8nq6QM/eoWSwgrJ22DNU82Jlr5VwhXiWB3XE4dfFYL1P0yLbXT5Ip3
         tJ9O9VaxXCw2ejBXvqJVvNogRb7MOZHNERkeQQEaJLLl7y8fF1W6cIbli6zBfWkhCf1S
         JX/TnqBZDGAMJX/7bslH0HBeViCr6xqM4qu59sJDqdvcNMsk26H1OFhFcBYM6fpU34p1
         3tvjiRQYPix5FkItgzThOwU/oVTxe/RaAIk/7pR2zmMVcAnMQAtpkfKCBCEjhCEXqw/z
         6UgQ==
X-Gm-Message-State: AOJu0YxvOJ1hQyJose3WULAAHc7mFzDF7zdVB7m6Bm1kGoA7Q9pCpOFi
	euQp6XbaD5+Gq4n68YdEL3lRs4/+YCap8g==
X-Google-Smtp-Source: AGHT+IHWgoyQ5LC4MBSkCi8h/A2dHM1byvT5+zUYwwDynrZKnoQB8VuvJnappg4TYS6DXhTPOrN9pQ==
X-Received: by 2002:a0c:fa8a:0:b0:63d:b75:c971 with SMTP id o10-20020a0cfa8a000000b0063d0b75c971mr10146029qvn.15.1691424006682;
        Mon, 07 Aug 2023 09:00:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1777])
        by smtp.gmail.com with ESMTPSA id o16-20020a0cf4d0000000b0063d385c28edsm2977607qvm.41.2023.08.07.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:00:06 -0700 (PDT)
Date: Mon, 7 Aug 2023 11:00:04 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH v4 1/1] bpf, docs: Formalize type notation and
 function semantics in ISA standard
Message-ID: <20230807160004.GA10339@maniforge>
References: <20230807140651.122484-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807140651.122484-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 10:06:48AM -0400, Will Hawkins wrote:
> Give a single place where the shorthand for types are defined and the
> semantics of helper functions are described.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Looks great, thanks Will!

Acked-by: David Vernet <void@manifault.com>


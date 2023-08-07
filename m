Return-Path: <bpf+bounces-7117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93477188E
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797B41C208A8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1DA10EA;
	Mon,  7 Aug 2023 02:55:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7FA20;
	Mon,  7 Aug 2023 02:55:29 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F291719B9;
	Sun,  6 Aug 2023 19:55:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-563f752774fso2109717a12.1;
        Sun, 06 Aug 2023 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691376901; x=1691981701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw6YeYl+42W56ILPnRQdhw7vhzVVQwbtgdY6eZmvNZw=;
        b=cn9LcF3ol6PAZxQoqmiPolR82kUUQhImtdThUZovGfuVTbKx9psxYZsYUlQ1ngrobH
         xwaieKOp/Hj051ym29wuirEV48FdFVdMaIvyAgDqNE+U91HqNmJHhXArWk9ALXO50ZFy
         3QkN1cwJt+9w46jkEwGUb3qBLZPOxVvcyonVsOyfpxviKJct75A+pzoNI8WioPIZnF+d
         MdnPgnPsR9ak8k+0u/PgB+FIs8Azqw6cofRIInncuD7S759AVI34Ri4QCCMJg3dcStN9
         4XFiRwchChAgOXCfBHv9DQPZ9haxU8Jz9huu8PEgmwiYt/U+nktCYZ1WBVzlH1EOFfCT
         lhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691376901; x=1691981701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw6YeYl+42W56ILPnRQdhw7vhzVVQwbtgdY6eZmvNZw=;
        b=btFff97E6dX2u8Tem1KTjiDitlzgOZfGE9Dj8zj7Afb1RxkQM3AB1pLOM15fsJ3bBD
         MhvRTrz+D6p3ry3mPxxTRRkcUqEEgcxlLP60CbSdw1lF6zRU7jpi4AgwWk249F4Lb2kQ
         ngOOOTDLAiCoJ7eywx+HfGKel7tuUQwoo9uMaDNCTTjOcVMJrUWRvk/ZciUrbJgs5cqN
         3q4pd7H8+nQFY6tEXZsi+H0xuMs7XjeznZ3s8+DD24CDGD7bkuEUyVRetMxxNip+xG3M
         NB6m9WZ9oyMiJKyEocj+IIjT4/5szVNvFkShcdPgk5Ou7ryS/bZZCDri0Xea/zkUYLG1
         crvQ==
X-Gm-Message-State: AOJu0Yxs2dQyhJf6Wa6Lk92gNjomuF4NAjeJANSzosLyaLQV0qKRWJEb
	xBuEFirb4V31PB5QFxVihq0=
X-Google-Smtp-Source: AGHT+IFnT58N7fr1rNnDjidG3fPkT5mRWlaMMiglYC/Lq4axiZ5fNQU+u0IJxl6JfRCkqBzCg5wu2Q==
X-Received: by 2002:a05:6a21:71c7:b0:137:514a:984f with SMTP id ay7-20020a056a2171c700b00137514a984fmr6140301pzc.35.1691376900876;
        Sun, 06 Aug 2023 19:55:00 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b86e17ecacsm5538891plb.131.2023.08.06.19.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:55:00 -0700 (PDT)
Date: Mon, 7 Aug 2023 10:54:55 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v3 0/5] team: do some cleanups in team driver
Message-ID: <ZNBc/4Os0y9j0nc7@Laptop-X1>
References: <20230807012556.3146071-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807012556.3146071-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:25:51AM +0800, Zhengchao Shao wrote:
> Do some cleanups in team driver.
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v3: add header file back to team_mode_activebackup.c
> v2: combine patch 5/6 and patch 6/6 into patch 5/5
> ---
> Zhengchao Shao (5):
>   team: add __exit modifier to team_nl_fini()
>   team: remove unreferenced header in broadcast and roundrobin files
>   team: change the init function in the team_option structure to void
>   team: change the getter function in the team_option structure to void
>   team: remove unused input parameters in lb_htpm_select_tx_port and
>     lb_hash_select_tx_port
> 
>  drivers/net/team/team.c                   | 62 +++++++++--------------
>  drivers/net/team/team_mode_activebackup.c |  8 ++-
>  drivers/net/team/team_mode_broadcast.c    |  1 -
>  drivers/net/team/team_mode_loadbalance.c  | 50 +++++++-----------
>  drivers/net/team/team_mode_roundrobin.c   |  1 -
>  include/linux/if_team.h                   |  4 +-
>  6 files changed, 48 insertions(+), 78 deletions(-)
> 
> -- 
> 2.34.1
> 


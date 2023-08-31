Return-Path: <bpf+bounces-9021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B478E4A7
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 04:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFF1C208C9
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6715A0;
	Thu, 31 Aug 2023 02:09:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3D10FA;
	Thu, 31 Aug 2023 02:09:11 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA483;
	Wed, 30 Aug 2023 19:09:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a81154c5f5so160555b6e.1;
        Wed, 30 Aug 2023 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693447749; x=1694052549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiJWGS9QSG5pm9eFpdJh/9c1XSBlOP0lrKi0Maa/xLI=;
        b=SCbfGoclBHKNQuGiaQafnJVL/U5UFRLw4rkNCnAfDud0bI9B1oy+FPehHD5tCakerb
         pjSDNbCE+HwiOw5r7CWLkiZ28HZSiwdwQFtSFo6pce1ZPuK+7s1s3a5rIcuMo8IBW5Q1
         TPT71EAa7nRDY6PVHteqDhBn2sB/MCHN0h41AthKY9753MhhiLgJuOB8zyHelV/glFie
         XX7XBDxbmEvj7VQkwKPkavgfnZ0n6lFCEs0BIBds/VtPWTnR5NjDAfxjz/bxT/uLdOPm
         15lCW71GtbfYi9kTkUB6Zq3rnH1Z8CkUmR5F1sVrK9gY6CiOkrtFtxK1ao4KXnKK0PmW
         h4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693447749; x=1694052549;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiJWGS9QSG5pm9eFpdJh/9c1XSBlOP0lrKi0Maa/xLI=;
        b=P3Umf2fT8WSIuXWWtZ/LENWnv1pKzhwbWVfW53XUz3j2bRYeSEHNlSQPnvEyJWxAW7
         FsiBqVOlYhCXKgWFgJbWx39yAZ3B6yzIJz0YThmH45UK2O4Dnyddru5Y82kNrRoIHllH
         ZafKQ0+oukYwQkp+gt4284x4IiQ9dacL0IBOkjF9RiMvM30/FSfp+AkDLkJjEoj5c9Ew
         G1ASrbKNBj5ZKn/OUXmTUXyZxnYDfS7jW/rFsQFZquNMKHqmhgOjh+tTdu65wGmQbaP0
         NW0RjmHnf21EuZkNddUW3tuXjjS0h41eIb0Tyyxrk2M90szsbvzKNOtsQc7doIC0Eier
         1krw==
X-Gm-Message-State: AOJu0YwsB7UaWmbkckkmHIs3s1h9CS1b9OjOqpqXHbswxoi7n1+PCw0X
	LwvAe0QXWK9K53YQMbrXlDo=
X-Google-Smtp-Source: AGHT+IGrfwKkZN3+Rw/So9KnHaZvT8lisPhNxPoJ1/P4sO+qGO53lvq/dUmv9nQ5OiG6qiAJv5lVVg==
X-Received: by 2002:a54:4887:0:b0:3a7:38a1:fd19 with SMTP id r7-20020a544887000000b003a738a1fd19mr3446377oic.37.1693447749387;
        Wed, 30 Aug 2023 19:09:09 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:6947:11d8:e02e:66d1])
        by smtp.gmail.com with ESMTPSA id k13-20020a63ab4d000000b005642a68a508sm274116pgp.35.2023.08.30.19.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 19:09:08 -0700 (PDT)
Date: Wed, 30 Aug 2023 19:09:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <64eff643ba8c8_9941c2083c@john.notmuch>
In-Reply-To: <20230831014346.2931397-1-xukuohai@huaweicloud.com>
References: <20230831014346.2931397-1-xukuohai@huaweicloud.com>
Subject: RE: [PATCH bpf-next] bpf, sockmap: Rename sock_map_get_from_fd to
 sock_map_prog_attach
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> What function sock_map_get_from_fd does is to attach a bpf prog to
> a sock map, so rename it to sock_map_prog_attach to make it more
> readable.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

I don't really think the rename is needed. It will just make any
backports difficult.


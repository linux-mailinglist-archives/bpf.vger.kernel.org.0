Return-Path: <bpf+bounces-11200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876647B53AC
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9EF611C20880
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4A18C2E;
	Mon,  2 Oct 2023 13:10:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5DCA74
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 13:10:45 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B07B3
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 06:10:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40537481094so168591885e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1696252242; x=1696857042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trOs+bS9qjB1tKtP7PdcIjgdydsrIJlX1JkiYwfzkv4=;
        b=ANm7Gu+jAIT2yO2ljlw0AhUOYhjiR3d4HS1w6yx4dsOHo64sGNeyMrVj/yzdgtk+v7
         7StyrLi9ElL4Qi70OJGBKcb/N21Y1jLdgZynFjfFHYlYAA7rESzoQQ5LqGb0jE5zYtB0
         01m6nyEWioEjL3H2/J72c5i/nBEl8mS63nJwTvTg8M3jP8GaZ+d+PkDtxYI0ivXAjHHq
         D28jfmQ7XiLN/lGKOSuVhHkPEyxsKdzMliVjdtvW4DIVPznx4Qp0WAc7q17GAkLPc8VK
         NMvOQqfFZnU87W5ZnlTmKTnUsWt+Nt43iRSCqiJpMEyPTBER+xemmEyxLiFLpFEgtsuf
         nCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252242; x=1696857042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trOs+bS9qjB1tKtP7PdcIjgdydsrIJlX1JkiYwfzkv4=;
        b=g3UDEFtYiu9wfJAXQPNwywz2MYv5yFpK4Bqn60kR7+qYjsES2DdlP52bJ2BJa9KYxh
         F/+sEetHHSt2tnbbBpflBWqY43JMFGZT/Lf8kdS3TSY3SJ2ixW/hcGeWZ+xoFzcu4n+x
         gukgO4BMM0u2J4O5pfjoqf/52VlDrraK4v9Yyc+OT1/IvOj6k4b5rPdy1G3nMVGXj2vN
         YNnzEUot/KPOe1WSTyiYVrVpHr1nZ1UXVpkG98tG21R9KmZihSMfpmwcPzyYYkV1BT0+
         f+sA6b7gq0GAZ/5WZq70sMy14fMug1FLi2zbc7f3Pnwq1YoxZsb4VjJIWGn4715MM7YZ
         tjaA==
X-Gm-Message-State: AOJu0Yz6O+nrjOItWSwXQpOvBbmyddo5fbePcvNdYYhuuQiGN6zXGwzK
	jO0FATlhZ3/h6aXsYGxUFZR1Ow==
X-Google-Smtp-Source: AGHT+IGgu8vs4o57DqfZX7XEqKXt7wI9oDp7v3YzpIyV4RsnX8UJ8LaX59vKyxY1HHLzvWlcHrbAKQ==
X-Received: by 2002:a7b:cb95:0:b0:3fb:e189:3532 with SMTP id m21-20020a7bcb95000000b003fbe1893532mr10530379wmi.20.1696252241941;
        Mon, 02 Oct 2023 06:10:41 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:236f:623a:5782:3a49? ([2a02:8011:e80c:0:236f:623a:5782:3a49])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcd0b000000b004053e9276easm7271249wmj.32.2023.10.02.06.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 06:10:41 -0700 (PDT)
Message-ID: <73591a73-c478-4e6e-8899-a05c4996b60e@isovalent.com>
Date: Mon, 2 Oct 2023 14:10:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
 <20231002122756.323591-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231002122756.323591-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/10/2023 13:27, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>

Please keep the tag if the patch has minor changes or no changes at all
between versions of your series.


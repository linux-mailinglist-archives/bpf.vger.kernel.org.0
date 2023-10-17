Return-Path: <bpf+bounces-12431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4597CC5CE
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2FC1C20C99
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882E43AB0;
	Tue, 17 Oct 2023 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSMOl7yA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69443A84
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:20:21 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD1B0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:20:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso51852155e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697552417; x=1698157217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtpS8Jls9+zXNA1fTCaP3J42bzkSyACzNnDJpS3nUnY=;
        b=dSMOl7yA8O6e0Cn9CWMHcfIkxp0///9r88c2YOnByejVqVRmfg83/XyKfZl8hBDszT
         fgek3UemPZdsfaNoBhPJ5CNTVvJhvX+A4lYgg+O9npW4KBxgyUfSoOxO+LWZrpYLlApV
         xyy1EuI4+dqo692IirDCVLDClu6FVE/V2NuTNs/VhtVmB3h4nvryWBNJ9H2V31S1nq0X
         O765KRQ568q0T4cicBL5kNmR6PU6HxsoiTw3zBcWi8lJiWvny5ejo4SgldYAcwMXzUn9
         Pvh7JxIxU7iaO6xCWU79frRdR9OuxmWLdfyZVtnxVTUU+GT89lDNyDBfXk64gus2hxUM
         +GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552417; x=1698157217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtpS8Jls9+zXNA1fTCaP3J42bzkSyACzNnDJpS3nUnY=;
        b=GOztrCB6tfrCyJ9CoQ/DX4fE084wqbhcC2dm8/cxPoigvmShJQ6ihARElD1JPwoK4M
         8OhP+72llCwQbhzF/Wxl9XiDbOzs+aNjBytNgNQIf9FgDCZYzlkb7FTI7cZPpzoE5jU9
         oFdrdvv8TzruMQw2Q16OduDNByBolFZnXx3uYkVjs6IHzZhbT4WMfvjTkF9J6gdabt51
         f3icWpKbkvGjMqxlG8RuEwOYaOH9IUSzR0Km6DOPwVyerYGs+WqQW2RD11HcR7CqtO8Z
         6YbpEEKarAID0gHJQnsxCGfL2FJW4k7hGOH0mkAAY3SOeewyTbINDGeeNKKZKl2OlXtD
         heqw==
X-Gm-Message-State: AOJu0Ywn1tWCezfqjcxNwAKk6sWmMc4CVCvwujOQ8842FMr1P513XH89
	gPhDyF1nw1M2NLQx3Dda3O1zYZM7Ziopr8GhS/M=
X-Google-Smtp-Source: AGHT+IGYzPu1OXbE8Xy0IW4MTqyHYBVECUBTNSt/SP1R7jW/19/NNOjg9B6fQN18++BOmQIStQcvxw==
X-Received: by 2002:a05:600c:3ba5:b0:408:3707:b199 with SMTP id n37-20020a05600c3ba500b004083707b199mr843309wms.3.1697552416907;
        Tue, 17 Oct 2023 07:20:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0032cc35c2ef7sm1804496wrx.29.2023.10.17.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:20:16 -0700 (PDT)
Date: Tue, 17 Oct 2023 17:20:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org
Subject: Re: [bug report] tcp: allow again tcp_disconnect() when threads are
 waiting
Message-ID: <ea24fdfa-73dd-41ab-b549-3fe72c3ad173@kadam.mountain>
References: <ba9236a1-f473-4561-9ec0-87daf364776a@moroto.mountain>
 <78ae0a2e925540ca99774f8f1758f5982562cab4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ae0a2e925540ca99774f8f1758f5982562cab4.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 04:14:53PM +0200, Paolo Abeni wrote:
> 
> and something similar in tcp_bpf_recvmsg(). I can send a patch (or you
> can go ahead if you prefer).

You know this code better than I.  ;)

regards,
dan carpenter


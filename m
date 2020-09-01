Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA325976D
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgIAQOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbgIAPf3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 11:35:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB6AC061244;
        Tue,  1 Sep 2020 08:35:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so1326813qkb.10;
        Tue, 01 Sep 2020 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pt5riNry0LXCdMMDirjaAvuNNxR72mnnngurjuADZZo=;
        b=OQ9fWUenknF9Q+nAncqv3JwfcFuORp9ef2xNGcB2GbZd1SeyaJtCYvuGT2hsWlAqmb
         2I0s+TbyT6aN/1H4W+LX4oqLaVm6fElKHZ/3RF0MRHeObQD8S8UAoPjsVUtEEe5BkQR9
         j9xZG86MQ+b0n/bT4QWLiPPRIgt8kmhTbMRfb3XMfXPZ/CmsIE/vn6bDdS+gdhi35OcD
         lTeZOalVPTuJZ2AvYShSeC/yD05B0RzZ+mJYR+QE8NhqK9W3+n15AoeUfcIWNMHL4Hd2
         CaZOr5GWGQqNEQqPsGiBjEhwGAEHbj0SXnIOpu8e0eq06KzxcjiB1IRFSu3dq9M0/O+u
         xU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pt5riNry0LXCdMMDirjaAvuNNxR72mnnngurjuADZZo=;
        b=MuoRdiBO7SaD3Dwy3odEkcuGwZidu2+z1GOZk9K0ch0sduMrf1F82RkwTUr2SABZuv
         FelD1QfJdfbKWe0NPyO9e//v2CbR3BINik3mYGBUYbH4T/BYhFNL/6ULj9ZOO04lS0VN
         4EojvyEEtMZoQUARJzQVnXyZoizRzFiHhV1M8mDQAKotGWacEPWhGvXq8FKEn3F/Zhyn
         lXpTqYRhClK3wa3ej5TmBkIzQPlAD9hF3kQRpy9mPAeHbHwdFUK3G313dE3yHR4hzUX+
         tyuuixEMoWU8YaDdu8MA2vw1msYENq+iPcZgp7woEGcpcTnie+csSIKekIOjw6FFQ6kY
         ZLug==
X-Gm-Message-State: AOAM533UmtX2JN136EBDBrunHzPVUKnc3BY+VeCR1CtG0SCu7+0LnagO
        Z6m+Lo0h9/m5zqePhoytuDk=
X-Google-Smtp-Source: ABdhPJxNPwyKBVSlUPOK2GEeBXN58bPo+Amwwb+B5yOvnjOXV0smnRsYTwJzbLJWIhWk8Ju0NzLxtA==
X-Received: by 2002:a05:620a:b1a:: with SMTP id t26mr2437752qkg.353.1598974527257;
        Tue, 01 Sep 2020 08:35:27 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:dd5a:a6db:5e16:1fed])
        by smtp.gmail.com with ESMTPSA id f7sm1971818qkj.32.2020.09.01.08.35.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 08:35:26 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:35:25 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 3/4] bpf: add eBPF IO filter documentation
Message-ID: <20200901153524.GB5599@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-4-leah.rumancik@gmail.com>
 <20200812115011.337c0099@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812115011.337c0099@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 11:50:11AM -0600, Jonathan Corbet wrote:
> Please wrap your text to a reasonable column width just like with any
> other kernel file.
> 
> Thanks,
> 
> jon

Will do.

Thanks,
Leah

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A758716FF13
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2020 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBZMdb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Feb 2020 07:33:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgBZMdb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 07:33:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so2880006wmb.0
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0kIIo1lecMssMrTUasr4Z+ioUkeaNygIbZqpO6tuy7U=;
        b=hfdLuYaaUMr9SBi7O2P91IYzUJ/zTJ2oS0bgVO7G20Gc0lV6lmNPq/5xN/1yLoCaez
         Z886k1//kTzEvgQADorL1StdQJeX4DGQR8jUCS6NcH9TQ4ajegwlK8MTW8lSAx9x4rQ7
         JHl9KZSvefslwO/hLtvmU8a/DLORpxStfHfCtwxmM+bDuFE54j0UQ19th6tTAiL2Ojnl
         wmPMjYPD0FMF3XsqrCEuH3UXNW3YMO7ecvcZNjMqCxRtpRp07Gl2ticJbytLAviZW9eq
         7cuyBOK/SGF7WKkVXBzN4G4WnMyqe7nQpCgWzl7pV43jy+4h9MsX8cnBOwv85R/yVaPP
         o2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0kIIo1lecMssMrTUasr4Z+ioUkeaNygIbZqpO6tuy7U=;
        b=FeWQrS8X1RVL2H4uOTp+OrOHuvQXFYbPrNVYiozDbhF8Ca24MkY6KtoD6r5NG5GU+3
         4TVlrJ8Y+qln2jaW3gx8JvahFtk6WWk9lGQrhbvQkHMvnpfrFt8nqK3N9X9H5GzJhacD
         3hzk0uKcndiMt6IY1uOhlj3IJZzZuSx5BZVIc4a3obrbZTsl/g4UfsG5bM+oc+bNhU0C
         SJd0l/0TVW9ymrYTopHrfGD9vk0HG7B+d5iR+jRfoYYqL4rl4C4OwGfhQVdLhyt3uOj2
         9yKo6CyfxKV8QqNawTqCW4WR+JW8gXcZw/ECieKkagNT4ivdJm999VrKEvhxUaUqj40k
         ArvQ==
X-Gm-Message-State: APjAAAWTJAPJOZWrpIKiqCW5LjGoMP2WAm2wVt7Ery4JZmTluDRnoBIX
        DokV1mE1ZV6OAJGn+7L2ADa7EJI+VRc=
X-Google-Smtp-Source: APXvYqzF4DjO+4GDUDHWRvcM3JgEw8aRfM0WfUIcWWSC7lry6yZFBDyky7ZCIKYhYahJy5QAQ29yoA==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr5646682wmb.185.1582720409669;
        Wed, 26 Feb 2020 04:33:29 -0800 (PST)
Received: from [192.168.1.10] ([194.35.116.65])
        by smtp.gmail.com with ESMTPSA id a62sm2785097wmh.33.2020.02.26.04.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 04:33:29 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 0/5] bpftool: Make probes which emit dmesg
 warnings optional
To:     Michal Rostecki <mrostecki@opensuse.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20200225194446.20651-1-mrostecki@opensuse.org>
 <e4929660-21ff-e394-37a0-d72b67a3770a@isovalent.com>
 <0e46d001-a137-97bc-262c-e864cf3f90b8@opensuse.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <b638238e-7e35-0ab0-3f0b-315ffd947a8c@isovalent.com>
Date:   Wed, 26 Feb 2020 12:33:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0e46d001-a137-97bc-262c-e864cf3f90b8@opensuse.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-02-26 13:17 UTC+0100 ~ Michal Rostecki <mrostecki@opensuse.org>

[...]

> I
> might follow up with some more tests covering the other subcommands in
> future.

That would be great!
Thanks,
Quentin

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26ED15864B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 00:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJXwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 18:52:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgBJXwU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Feb 2020 18:52:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so4751404pgk.0;
        Mon, 10 Feb 2020 15:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WFa85gGE/LtVRnV5ld2vW9uKKj6RahA14184rtqSA/U=;
        b=JxpgqTKmCO5NqieLU/ylURDa5S9IbFc6qH5GL04DgXIDz40ok5jyeB4u4uXGqsNHE+
         HPTr0Uag0cw2e0KMEXlDR2NOiqLzuwwCAX1gVZvbv5WA6fgKvJoCzgrc9qu8dP5pKaTH
         0sI0vrF8GAFeAKWZjoe2SKhq/W+WK3XOKXMBhn7s+yMa8SdTeKHxWT80dZO2af3ADfTk
         iVCMP7j7QUV1/oF8JRhNJLL3bjCjxCKBMLIHtpUyGMhje3Lzu/hTd7r08+3re/cY0UHO
         tryrPc5mb6iGbqVDuTLGX2YL/oZpfZPiajHR8voMFDZGK6CJqb4XY2sHwj4n7BMtW1Va
         cQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFa85gGE/LtVRnV5ld2vW9uKKj6RahA14184rtqSA/U=;
        b=q6V99xBH65bBQzxOkN2Trejg5smwQ3VW6Hd3q2669zgkQsjZrZDRjGB15rOOmYeXJ2
         Du04CYHoQxX680RIGUYoaOwATnpWCwA2aNAe5L36aClOHpnL+YzoNcFueZHmDBw5JXis
         dCVZZgDcaHE5cfFK+mQBiu3WfIzxxh8z4qe7NiXvmSuIHWxr9t2IWoVZvY76QgVPnM9N
         dp3PAhlActQhIAQOgy9MzfjnW0OaPMuic5WAw7P0tWcg7vCT594z17iRpF7hJOF9IP76
         Fm0VylchxpWUBZ331dlUL3lpCwrrGgLYDVBGQ5aP5eH6jsOv5pU96QP5bjhOJ/xF3JOa
         FE0w==
X-Gm-Message-State: APjAAAWgf0hoaKZkOs4FG7wVllGeyJ+OoDyIZKSLsEN7zFbIrX4vOTQt
        CBihKiFJFGnsv3v9JQ4dJBsrRCpk
X-Google-Smtp-Source: APXvYqxQk3F7wmOR123h1ImJsvuDOwQ1QGNPqDSoBjpTnsN7ABC9ber17yPoHqUY2g4fVbaTjfEm6A==
X-Received: by 2002:a63:7a1a:: with SMTP id v26mr4025731pgc.51.1581378739046;
        Mon, 10 Feb 2020 15:52:19 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::2:685c])
        by smtp.gmail.com with ESMTPSA id c15sm1467421pfo.137.2020.02.10.15.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 15:52:18 -0800 (PST)
Date:   Mon, 10 Feb 2020 15:52:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v3 02/10] bpf: lsm: Add a skeleton and config
 options
Message-ID: <20200210235214.ypb56vrkvzol3qdu@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-3-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123152440.28956-3-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 07:24:32AM -0800, KP Singh wrote:
>  
> +BPF SECURITY MODULE
> +M:	KP Singh <kpsingh@chromium.org>
> +L:	linux-security-module@vger.kernel.org
> +L:	bpf@vger.kernel.org
> +S:	Maintained
> +F:	security/bpf/

Instead of creating new entry I think it's more appropriate
to add this to main BPF entry like:
diff --git a/MAINTAINERS b/MAINTAINERS
index c74e4ea714a5..f656ddec0722 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3147,6 +3147,7 @@ R:        Martin KaFai Lau <kafai@fb.com>
 R:     Song Liu <songliubraving@fb.com>
 R:     Yonghong Song <yhs@fb.com>
 R:     Andrii Nakryiko <andriin@fb.com>
+R:     KP Singh <kpsingh@chromium.org>
 L:     netdev@vger.kernel.org
 L:     bpf@vger.kernel.org
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
@@ -3172,6 +3173,7 @@ F:        samples/bpf/
 F:     tools/bpf/
 F:     tools/lib/bpf/
 F:     tools/testing/selftests/bpf/
+F:     security/bpf/
 K:     bpf
 N:     bpf

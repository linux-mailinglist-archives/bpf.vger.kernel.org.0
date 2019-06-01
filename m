Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9900B31885
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2019 02:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfFAABJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 May 2019 20:01:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44974 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfFAABJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 May 2019 20:01:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so9236159lfm.11;
        Fri, 31 May 2019 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKdvwn9RwsVp3ATSXapbe6ZW0aek57t8ojH7+ian7HM=;
        b=kL/lYlFfJthahRmW8UDam8MACxdtYLAUTRKt4DilMNwK9KrzfJ58WAdyPV38esLCb2
         zJ8538tu9N4Qk6rfPAzB+cl3gsk76G1vkfDUVUTb0LW441SNGEKRE1tQ1n1y/3rZDJ5L
         Q5GmOgdpWUcz8nzMaVXDMydQsnUyaloQFx11y9lIMXlNyOb+HXPVBUwYq7RJKF6Kwpfp
         R5axTB/E4JIlw+a5JbO+Gs7DjmeCN0BhwOjybvc81c/B4/QuiJW4LM9rkUGEaPj4TWUe
         Wd+pyvuDGwPoP5Qo+wWtoTbpAuI3CD/+tANzbcndRz43iyun+CHf/E3pu6plNzdzHbi7
         kb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKdvwn9RwsVp3ATSXapbe6ZW0aek57t8ojH7+ian7HM=;
        b=C8sx+87QN+POsM5LfiK1bNFYbSgbVxINMT7pSbSaQ4eSyhuohiaf6kZRTMHEd8nkTM
         oeEVH8QO0V4J28WhvlAfore0QN9qz9pm5D9a0VSlobcftFEMtqHjRiniI2vxYGySqKmD
         Ec4QsUat9UjLvZmWLQslc5tWZeV8FueQQlwHX+mlSFThqWoHCumI3nmBqAibfHgTJGtm
         wbsRdwLmj+HbeauZZtsIT9czVqd4PvDn7PUMw8/OtvWCPnuB6CA1rhqXHZ/fe1bKjTpc
         J58Mi/a2aGXqpwXd/5GOcCe0hO8v7xQKUjcCxjxfkvuy6oIwaHw4CL2x7TpAZHYdRO+A
         X3Wg==
X-Gm-Message-State: APjAAAVy6f++vmfsyPMrrAYVlqdjc5OoGrXLfuJe3iIY1AQuS1AQ/Xsc
        d+q+efjjqpiVNb/U1nt8oM+jihQPM2UnZfmKXXk=
X-Google-Smtp-Source: APXvYqznjO5XK58TWy6Smzmc/NgjZWLcWIv6IboQBhMU2TwYzgdkZQ4gZu6P+so9ZG43jy2N3EJq4LrdDcQHBrOvfHY=
X-Received: by 2002:ac2:4252:: with SMTP id m18mr7059629lfl.100.1559347267743;
 Fri, 31 May 2019 17:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190530010359.2499670-1-guro@fb.com>
In-Reply-To: <20190530010359.2499670-1-guro@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 31 May 2019 17:00:56 -0700
Message-ID: <CAADnVQKCYDdP2xvmV4P38Ewh5YgyPnT-EV10oWrUpeCCJBrqcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: bpf maps memory accounting cleanup
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 6:04 PM Roman Gushchin <guro@fb.com> wrote:
>
> During my work on memcg-based memory accounting for bpf maps
> I've done some cleanups and refactorings of the existing
> memlock rlimit-based code. It makes it more robust, unifies
> size to pages conversion, size checks and corresponding error
> codes. Also it adds coverage for cgroup local storage and
> socket local storage maps.
>
> It looks like some preliminary work on the mm side might be
> required to start working on the memcg-based accounting,
> so I'm sending these patches as a separate patchset.

Applied. Thanks

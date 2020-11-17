Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B712B5961
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 06:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgKQFi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 00:38:29 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:54690 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgKQFi3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 00:38:29 -0500
X-Greylist: delayed 1350 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 00:38:28 EST
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 5BD2E1E0766
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 22:15:58 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id etLRkac3Xh41letLSkfeC9; Mon, 16 Nov 2020 22:15:58 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=JrnfUvwC c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=pGLkceISAAAA:8
 a=jtbBNqsHAAAA:8 a=-ewzHdp9FFKJ1sXwa_MA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=RWaeYqt-Cn-VcsFsiLGo:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UQyFykvQVTwc24qYJBcae8eSoAzAlxI0Tnd7zOVCoKU=; b=EDQ0fqviE9CQsRJDq23M3o2wgl
        xXbuXMOOg4Cx7I3kr0N4RlZyI2ybQ+8sam9EGoGNzDL+czNM7sBpfHkqh/jdCa9KipiWHC/h3K2WQ
        YdSdkItu1dkVDdT8fz2Vt4EZwEuUPxNVxYj9VPMlueEhqsKD4Rg3Tf5JFLCJUwrKfAHNvPw2XutBL
        gmS947YYdDsbqnqDBFhm55s6Ff+mx+fDQRjJ0ojuiul7LG+QIW+MK6A1ZLtnM6E1vdIu06IcOxwx+
        x9aYZmDM9O8vOHOgF2KnSFoZXui1XeIzl8yUyNU82fSTOTeBTQzO6Nby9Wrx1NenrzWAaCjozKOhZ
        TDYb9f3g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47310 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1ketLQ-003qy2-D7; Tue, 17 Nov 2020 05:15:56 +0000
Date:   Mon, 16 Nov 2020 21:15:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     rentao.bupt@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, openbmc@lists.ozlabs.org, taoren@fb.com,
        mikechoi@fb.com
Subject: Re: [PATCH 2/2] docs: hwmon: Document max127 driver
Message-ID: <20201117051555.GB208504@roeck-us.net>
References: <20201117010944.28457-1-rentao.bupt@gmail.com>
 <20201117010944.28457-3-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117010944.28457-3-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ketLQ-003qy2-D7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:47310
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 21
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 05:09:44PM -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add documentation for max127 hardware monitoring driver.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  Documentation/hwmon/index.rst  |  1 +
>  Documentation/hwmon/max127.rst | 43 ++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/hwmon/max127.rst
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 408760d13813..0a07b6000c20 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -111,6 +111,7 @@ Hardware Monitoring Kernel Drivers
>     ltc4245
>     ltc4260
>     ltc4261
> +   max127
>     max16064
>     max16065
>     max1619
> diff --git a/Documentation/hwmon/max127.rst b/Documentation/hwmon/max127.rst
> new file mode 100644
> index 000000000000..e50225a61c1a
> --- /dev/null
> +++ b/Documentation/hwmon/max127.rst
> @@ -0,0 +1,43 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver max127
> +====================
> +
> +Author:
> +
> +  * Tao Ren <rentao.bupt@gmail.com>
> +
> +Supported chips:
> +
> +  * Maxim MAX127
> +
> +    Prefix: 'max127'
> +
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX127-MAX128.pdf
> +
> +Description
> +-----------
> +
> +The MAX127 is a multirange, 12-bit data acquisition system (DAS) providing
> +8 analog input channels that are independently software programmable for
> +a variety of ranges. The available ranges are {0,5V}, {0,10V}, {-5,5V}
> +and {-10,10V}.
> +
> +The MAX127 features a 2-wire, I2C-compatible serial interface that allows
> +communication among multiple devices using SDA and SCL lines.
> +
> +Sysfs interface
> +---------------
> +
> +  ============== ==============================================================
> +  in[0-7]_input  The conversion value for the corresponding channel.
> +		 RO
> +
> +  in[0-7]_min    The lower limit (in Volt) for the corresponding channel.
> +		 For the MAX127, it will be adjusted to -10, -5, or 0.
> +		 RW
> +
> +  in[0-7]_max    The higher limit (in Volt) for the corresponding channel.
> +		 For the MAX127, it will be adjusted to 0, 5, or 10.
> +		 RW

This should explain that the limits set the ADC range.

> +  ============== ==============================================================
> -- 
> 2.17.1
> 

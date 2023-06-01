Return-Path: <bpf+bounces-1596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F2071EEF5
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562021C208D9
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B44251F;
	Thu,  1 Jun 2023 16:28:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98C22D6B
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:28:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B313D;
	Thu,  1 Jun 2023 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wS5z5XZ3GwNBhgY0jkt2hM/yAdpoSIWainSnIml/Rz4=; b=dYw32r9m48hdVLk/6D2V2fbqUP
	p2KufS/wPNdPzllKZPB1OM37qvcHOj+7y+mluZrTD9YmqsljOYZC0dPJBcH1Pl8QZn5JTH9gAW/N1
	+OscDg1XJ2Bze+lT7Y1a9eVUuXepOqkGXvO+2PJmlPEPiCyadjyad5w1cIoYBNG3j/dc87nbjeXBg
	sJsVfI63fE2fMqg+27klri3ElflTyYm3Pm6iOrYp0aHG3GyijuFiQ0Ua35xkybNXGWuw1dZvfOdXC
	oAk5xYQCnyQ1B/ft0/UfN/66jLEs3qekhReMHXPZ9blydffBwSU5L6lrMUtgInNRJLvvSB2CIi4RS
	GXx0hFQQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q4lAH-004FYf-0I;
	Thu, 01 Jun 2023 16:28:41 +0000
Message-ID: <3c6d7ab9-dac5-6950-db8d-3119e4529eb7@infradead.org>
Date: Thu, 1 Jun 2023 09:28:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] Documentation: subsystem-apis: Categorize remaining
 subsystems
Content-Language: en-US
To: Costa Shulyupin <costa.shul@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:BPF [MISC]" <bpf@vger.kernel.org>
References: <ZHgM0qKWP3OusjUW@debian.me>
 <20230601145556.3927838-1-costa.shul@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230601145556.3927838-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi--

On 6/1/23 07:55, Costa Shulyupin wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Add classes:
> * Core subsystems
> * Storage
> * Networking
> * Peripherals and devices
> * Embedded systems
> * Integrity
> * Virtualization
> * Miscellaneous
> 
> There is a FIXME that says to organize subsystems listed in
> subsystem-apis.rst. Fulfill it by categorize remaining subsytems
> by purpose/themes, while sorting entries in each category.
> 
> HID devices are already categorized in 3c591cc954d56e ("docs:
> consolidate human interface subsystems").
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

This is a worthy goal, I am sure, but I am also sure that there is
a lot of bikeshedding that can go on here.
(examples below)

> 
> ---
> 
> Changes:
> v3: add Integrity, Virtualization and Miscellaneous per Bagas Sanjaya
> v2: add Core subsystems, Networking, Peripherals and Embedded
> v1: add Storgre category

          Storage

> ---
>  Documentation/subsystem-apis.rst | 119 ++++++++++++++++++++++---------
>  1 file changed, 86 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 55c90d5383ef..2c0b18a66e4e 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -10,58 +10,111 @@ is taken directly from the kernel source, with supplemental material added
>  as needed (or at least as we managed to add it — probably *not* all that is
>  needed).
>  
> +Core subsystems
> +---------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   core-api/index
> +   cpu-freq/index
> +   driver-api/index
> +   locking/index
> +   mm/index
> +   power/index
> +   scheduler/index
> +   timers/index
> +   wmi/index
> +
>  Human interfaces
>  ----------------
>  
>  .. toctree::
>     :maxdepth: 1
>  
> -   input/index
> +   fb/index
> +   gpu/index
>     hid/index
> +   input/index
>     sound/index
> -   gpu/index
> -   fb/index
>  
> -**Fixme**: much more organizational work is needed here.
> +Storage
> +-------
>  
>  .. toctree::
>     :maxdepth: 1
>  
> -   driver-api/index
> -   core-api/index
> -   locking/index
> -   accounting/index
>     block/index
>     cdrom/index
> -   cpu-freq/index
> -   fpga/index
> -   i2c/index
> -   iio/index
> -   isdn/index
> +   filesystems/index
> +   pcmcia/index

Why is pcmcia in the storage category?
It's just an interface (or a bus).

> +   scsi/index

SCSI is also just a bus, but most (all?) of our drivers
are for storage controllers AFAIK, although I have seen
SCSI printer drivers, maybe even a SCSI toaster driver. :)

> +   target/index
> +
> +
> +Networking
> +----------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   bpf/index
>     infiniband/index
> -   leds/index
> +   isdn/index
> +   mhi/index
>     netlabel/index
>     networking/index
> -   pcmcia/index
> -   power/index
> -   target/index
> -   timers/index
> +
> +
> +Peripherals and devices
> +-----------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   PCI/index
> +   hwmon/index
> +   leds/index
> +   misc-devices/index
> +   usb/index
> +
> +
> +Embedded systems
> +----------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   fpga/index
> +   i2c/index

I2C is just a bus IMO.
Same with SPI and W1.
Should we have a "Bus Interfaces" category?

> +   iio/index
> +   peci/index
>     spi/index
>     w1/index
> -   watchdog/index
> +
> +Integrity
> +---------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   crypto/index
> +   security/index
> +
> +Virtualization
> +--------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     virt/index
> -   hwmon/index
> +
> +Miscellaneous
> +-------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     accel/index
> -   security/index
> -   crypto/index
> -   filesystems/index
> -   mm/index
> -   bpf/index
> -   usb/index
> -   PCI/index
> -   scsi/index
> -   misc-devices/index
> -   scheduler/index
> -   mhi/index
> -   peci/index
> -   wmi/index
> +   accounting/index
> +   watchdog/index

Thanks.
-- 
~Randy


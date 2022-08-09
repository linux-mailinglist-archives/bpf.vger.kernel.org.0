Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21658DC5E
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiHIQqY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244278AbiHIQqW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:46:22 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC315824;
        Tue,  9 Aug 2022 09:46:21 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38686)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oLSN1-00DYy5-DC; Tue, 09 Aug 2022 10:46:19 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:59550 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oLSN0-00CC7s-6m; Tue, 09 Aug 2022 10:46:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220809094300.83116-1-hadess@hadess.net>
        <20220809094300.83116-2-hadess@hadess.net>
Date:   Tue, 09 Aug 2022 11:46:11 -0500
In-Reply-To: <20220809094300.83116-2-hadess@hadess.net> (Bastien Nocera's
        message of "Tue, 9 Aug 2022 11:42:59 +0200")
Message-ID: <87y1vx2wmk.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oLSN0-00CC7s-6m;;;mid=<87y1vx2wmk.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18Q6uZYLE+UggLOmHt7CYT66TW5R52dKpQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Bastien Nocera <hadess@hadess.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 638 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.7%), b_tie_ro: 2.9 (0.4%), parse: 0.88
        (0.1%), extract_message_metadata: 10 (1.5%), get_uri_detail_list: 2.5
        (0.4%), tests_pri_-1000: 4.0 (0.6%), tests_pri_-950: 1.04 (0.2%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 129 (20.2%), check_bayes:
        120 (18.9%), b_tokenize: 10 (1.6%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 95 (14.8%), b_finish: 0.87
        (0.1%), tests_pri_0: 475 (74.5%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.6 (0.4%), tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bastien Nocera <hadess@hadess.net> writes:

> There is a need for userspace applications to open USB devices directly,
> for all the USB devices without a kernel-level class driver[1], and
> implemented in user-space.
>
> As not all devices are built equal, we want to be able to revoke
> access to those devices whether it's because the user isn't at the
> console anymore, or because the web browser, or sandbox doesn't want
> to allow access to that device.
>
> This commit implements the internal API used to revoke access to USB
> devices, given either bus and device numbers, or/and a user's
> effective UID.
>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
>
> [1]:
> Non exhaustive list of devices and device types that need raw USB access:
> - all manners of single-board computers and programmable chips and
> devices (avrdude, STLink, sunxi bootloader, flashrom, etc.)
> - 3D printers
> - scanners
> - LCD "displays"
> - user-space webcam and still cameras
> - game controllers
> - video/audio capture devices
> - sensors
> - software-defined radios
> - DJ/music equipment
> - protocol analysers
> - Rio 500 music player
> ---
>  drivers/usb/core/devio.c | 79 ++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/core/usb.h   |  2 +
>  2 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index b5b85bf80329..d8d212ef581f 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -78,6 +78,7 @@ struct usb_dev_state {
>  	int not_yet_resumed;
>  	bool suspend_allowed;
>  	bool privileges_dropped;
> +	bool revoked;
>  };
>  
>  struct usb_memory {
> @@ -183,6 +184,13 @@ static int connected(struct usb_dev_state *ps)
>  			ps->dev->state != USB_STATE_NOTATTACHED);
>  }
>  
> +static int disconnected_or_revoked(struct usb_dev_state *ps)
> +{
> +	return (list_empty(&ps->list) ||
> +			ps->dev->state == USB_STATE_NOTATTACHED ||
> +			ps->revoked);
> +}
> +
>  static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
>  {
>  	struct usb_dev_state *ps = usbm->ps;
> @@ -237,6 +245,9 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>  	dma_addr_t dma_handle;
>  	int ret;
>  
> +	if (disconnected_or_revoked(ps))
> +		return -ENODEV;
> +
>  	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
>  	if (ret)
>  		goto error;
> @@ -310,7 +321,7 @@ static ssize_t usbdev_read(struct file *file, char __user *buf, size_t nbytes,
>  
>  	pos = *ppos;
>  	usb_lock_device(dev);
> -	if (!connected(ps)) {
> +	if (disconnected_or_revoked(ps)) {
>  		ret = -ENODEV;
>  		goto err;
>  	} else if (pos < 0) {
> @@ -2315,7 +2326,7 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
>  	if (ps->privileges_dropped)
>  		return -EACCES;
>  
> -	if (!connected(ps))
> +	if (disconnected_or_revoked(ps))
>  		return -ENODEV;
>  
>  	/* alloc buffer */
> @@ -2555,7 +2566,7 @@ static int proc_forbid_suspend(struct usb_dev_state *ps)
>  
>  static int proc_allow_suspend(struct usb_dev_state *ps)
>  {
> -	if (!connected(ps))
> +	if (disconnected_or_revoked(ps))
>  		return -ENODEV;
>  
>  	WRITE_ONCE(ps->not_yet_resumed, 1);
> @@ -2580,6 +2591,66 @@ static int proc_wait_for_resume(struct usb_dev_state *ps)
>  	return proc_forbid_suspend(ps);
>  }
>  
> +static int usbdev_revoke(struct usb_dev_state *ps)
> +{
> +	struct usb_device *dev = ps->dev;
> +	unsigned int ifnum;
> +	struct async *as;
> +
> +	if (ps->revoked) {
> +		usb_unlock_device(dev);
> +		return -ENODEV;
> +	}
> +
> +	snoop(&dev->dev, "%s: REVOKE by PID %d: %s\n", __func__,
> +	      task_pid_nr(current), current->comm);
> +
> +	ps->revoked = true;
> +
> +	for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed);
> +			ifnum++) {
> +		if (test_bit(ifnum, &ps->ifclaimed))
> +			releaseintf(ps, ifnum);
> +	}
> +	destroy_all_async(ps);
> +
> +	as = async_getcompleted(ps);
> +	while (as) {
> +		free_async(as);
> +		as = async_getcompleted(ps);
> +	}
> +
> +	wake_up(&ps->wait);
> +
> +	return 0;
> +}
> +
> +int usb_revoke_for_euid(struct usb_device *udev,
> +		int euid)
                ^^^

At a minimum that should be a kuid_t.

> +{
> +	struct usb_dev_state *ps;
> +
> +	usb_lock_device(udev);
> +
> +	list_for_each_entry(ps, &udev->filelist, list) {
> +		if (euid >= 0) {
                    ^^^^^^^^^
That test should be uid_valid.

> +			kuid_t kuid;
> +
> +			if (!ps || !ps->cred)
> +				continue;
> +			kuid = ps->cred->euid;
> +			if (kuid.val != euid)
                        ^^^^^^^^^^^^^^^^^^^^^
That test should be if (!uid_eq(ps->cred->euid, euid))


The point is that inside the kernel all uid data should be dealt with
in the kuid_t data type.  So as to avoid confusing uids with some other
kind of integer data.

> +				continue;
> +		}
> +
> +		usbdev_revoke(ps);
> +	}
> +
> +out:
> +	usb_unlock_device(udev);
> +	return 0;
> +}
> +
>  /*
>   * NOTE:  All requests here that have interface numbers as parameters
>   * are assuming that somehow the configuration has been prevented from
> @@ -2623,7 +2694,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  #endif
>  	}
>  
> -	if (!connected(ps)) {
> +	if (disconnected_or_revoked(ps)) {
>  		usb_unlock_device(dev);
>  		return -ENODEV;
>  	}
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 82538daac8b8..5b007530a1cf 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -34,6 +34,8 @@ extern int usb_deauthorize_device(struct usb_device *);
>  extern int usb_authorize_device(struct usb_device *);
>  extern void usb_deauthorize_interface(struct usb_interface *);
>  extern void usb_authorize_interface(struct usb_interface *);
> +extern int usb_revoke_for_euid(struct usb_device *udev,
> +		int euid);
>  extern void usb_detect_quirks(struct usb_device *udev);
>  extern void usb_detect_interface_quirks(struct usb_device *udev);
>  extern void usb_release_quirk_list(void);

Eric

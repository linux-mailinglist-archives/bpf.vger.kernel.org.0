Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0833758DD05
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbiHIRWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiHIRWa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:22:30 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F77237E9;
        Tue,  9 Aug 2022 10:22:29 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46322)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oLSw0-005eCe-As; Tue, 09 Aug 2022 11:22:28 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:33506 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oLSvy-002dVo-BS; Tue, 09 Aug 2022 11:22:27 -0600
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
        <20220809094300.83116-3-hadess@hadess.net>
Date:   Tue, 09 Aug 2022 12:22:19 -0500
In-Reply-To: <20220809094300.83116-3-hadess@hadess.net> (Bastien Nocera's
        message of "Tue, 9 Aug 2022 11:43:00 +0200")
Message-ID: <87bkst2uyc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oLSvy-002dVo-BS;;;mid=<87bkst2uyc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19Eu7grO+Ml9igqd0AwMwRKfHvRJDtHVgk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Bastien Nocera <hadess@hadess.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1450 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.7 (0.3%), b_tie_ro: 2.5 (0.2%), parse: 1.17
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 2.6
        (0.2%), tests_pri_-1000: 16 (1.1%), tests_pri_-950: 1.63 (0.1%),
        tests_pri_-900: 1.31 (0.1%), tests_pri_-90: 79 (5.4%), check_bayes: 77
        (5.3%), b_tokenize: 8 (0.6%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        1.69 (0.1%), b_tok_touch_all: 55 (3.8%), b_finish: 0.67 (0.0%),
        tests_pri_0: 1323 (91.2%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 3.5 (0.2%), poll_dns_idle: 0.32 (0.0%), tests_pri_10:
        1.79 (0.1%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bastien Nocera <hadess@hadess.net> writes:

> This functionality allows a sufficiently privileged user-space process
> to upload a BPF programme that will call to usb_revoke_device() as if
> it were a kernel API.
>
> This functionality will be used by logind to revoke access to devices on
> fast user-switching to start with.
>
> logind, and other session management software, does not have access to
> the file descriptor used by the application so other identifiers
> are used.

Revoking access to hardware devices when switching users is entirely
reasonable.

I really think a system call or possibly and ioctl would be more
appropriate than having to load a bpf program to perform the work of a
system call.

Making it so that logind can't run in any kind of container seems like a
very unfortunate design choice.

The tty subsystem has something like this with the vhangup system
call, and the bsd have revoke(2).  So there is definitely precedent for
doing something like this.

I suspect what you want to pass is an O_PATH file descriptor to the
appropriate device node.   That should allow races to be eliminated,
or at the very least seriously reduced.

Eric



>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/usb/core/usb.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2f71636af6e1..ca394848a51e 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -38,6 +38,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
>  #include <linux/usb/of.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
>  
>  #include <asm/io.h>
>  #include <linux/scatterlist.h>
> @@ -438,6 +440,41 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +struct usb_revoke_match {
> +	int busnum, devnum; /* -1 to match all devices */
> +	int euid; /* -1 to match all users */
> +};
> +
> +static int
> +__usb_revoke(struct usb_device *udev, void *data)
> +{
> +	struct usb_revoke_match *match = data;
> +
> +	if (match->devnum >= 0 && match->busnum >= 0) {
> +		if (match->busnum != udev->bus->busnum ||
> +		    match->devnum != udev->devnum) {
> +			return 0;
> +		}
> +	}
> +
> +	usb_revoke_for_euid(udev, match->euid);
> +	return 0;
> +}
> +
> +noinline int
> +usb_revoke_device(int busnum, int devnum, unsigned int euid)
> +{
> +	struct usb_revoke_match match;
> +
> +	match.busnum = busnum;
> +	match.devnum = devnum;
> +	match.euid = euid;
> +
> +	usb_for_each_dev(&match, __usb_revoke);
> +
> +	return 0;
> +}
> +
>  #ifdef	CONFIG_PM
>  
>  /* USB device Power-Management thunks.
> @@ -1004,6 +1041,15 @@ static void usb_debugfs_cleanup(void)
>  /*
>   * Init
>   */
> +BTF_SET_START(usbdev_kfunc_ids)
> +BTF_ID(func, usb_revoke_device)
> +BTF_SET_END(usbdev_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set usbdev_kfunc_set = {
> +	.owner     = THIS_MODULE,
> +	.check_set = &usbdev_kfunc_ids,
> +};
> +
>  static int __init usb_init(void)
>  {
>  	int retval;
> @@ -1035,9 +1081,14 @@ static int __init usb_init(void)
>  	if (retval)
>  		goto hub_init_failed;
>  	retval = usb_register_device_driver(&usb_generic_driver, THIS_MODULE);
> +	if (retval)
> +		goto register_failed;
> +	retval = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &usbdev_kfunc_set);
>  	if (!retval)
>  		goto out;
> +	usb_deregister_device_driver(&usb_generic_driver);
>  
> +register_failed:
>  	usb_hub_cleanup();
>  hub_init_failed:
>  	usb_devio_cleanup();

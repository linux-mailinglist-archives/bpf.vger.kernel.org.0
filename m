Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40219DD73
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgDCSGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Apr 2020 14:06:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46080 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgDCSGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Apr 2020 14:06:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id u4so8921836qkj.13
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2020 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jI4MPZ+407qBrB7BW/I/HGZvR1WIFnXi1aza4Y9SsFQ=;
        b=SupQKYxpE8gbDBDzCN/4G4PY85zzwbFB6pvsxwwYjUE+bQuhCMGZfLo8PdRWW8nbvV
         X8YKJZEM7fxcewpW+alGiHKPP53DI+QITQfrJgltJKWWxfDAbYGDk/Bn8mfR73Y22iGL
         ySnlVvyWajEOedCXbUfMpPnHkb5CLdeVAVEbNOU6dp0dMOoxRfTq6O5QnEpskTeI8oUX
         M88ne1NwPeVE4X46eyfjwj7kix2HMM4JlRAKtly8XIXxv6xLKxvK1O8ROHbrU2lINJj7
         DFBw8q/1tRyHNC9//JeAV07JIQQ/haP1og9Jv7oUmXCX/+HmI8C3WyB/fzUzuQueLc9S
         kH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jI4MPZ+407qBrB7BW/I/HGZvR1WIFnXi1aza4Y9SsFQ=;
        b=Zf0rVqheR5UstUT4hAHDOl2ENtDsd4+Oh5eHO4QRD50l0VR2nUK9jkRqeW9Vro+nUp
         Nb62BMBWu6ldoig/OaSIp+npf2hmrCC/7ihYgrfGHRDdUbe4Z1EdRFOMssx+3s81iMvp
         F/m0nv1cJBzQ9Ke69oyl/j+PovdvRkebXezcwgbPdpTGu+7px+H9cFjZyRz23RJfRMnz
         X4L1umxFLHS0qc7OeST9KstI7RAWMn8pAfhAruN2Pw8jxytRDI3+2QOleBCZ5VXLfxGN
         AOAlk0ZMmdkFEBGM5UsLvjMvOpWDPkpi4yvkMtmoErKjf1sBkPw7JniIlbc0MIvBK9d1
         DClQ==
X-Gm-Message-State: AGi0PuaxtO6tfOjuIjJHeGIup6g7ZsHU+rDrNgZA+x/DYoJn//UkenMs
        xnFThdfftcd9TN502if3CUzKcjAZzIdFOLWGqAuT2xOXLjwZoHmB
X-Google-Smtp-Source: APiQypL+/GQqyo3E20GV5a17Pp1eqwBVd/nfJQB2qgX43W1nA7BCnYEqFNdYZfXNQVCw6d9nKs+tN6rZpOEVxDxE90I=
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr10143025qkb.121.1585937158639;
 Fri, 03 Apr 2020 11:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200403175528.225990-1-odin@ugedal.com>
In-Reply-To: <20200403175528.225990-1-odin@ugedal.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Fri, 3 Apr 2020 20:05:46 +0200
Message-ID: <CAFpoUr11o6m5oS7Dtt9FM02JmPg4oJFaUQcD+R+7ckoR=QETqg@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Harish.Kasiviswanathan@amd.com,
        guro@fb.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi (patch author here),

This is my first "real" patch, so looking forward to some feedback! I
am not sure if this behavior is the "best one", or if we should
require CONFIG_CGROUP_DEVICE to be set to yes. In that case we can
just abandon this patch and replace the original "#if
defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)" with a
simple "#ifdef CONFIG_CGROUP_DEVICE" and update the docs and the
config.

It is also another alternative to keep the code in this patch and move
some of it into a separate file in order to avoid all the ifdefs, and
to make the split between cgroup v1 and cgroup v2 code cleaner.

As a reference, only Fedora is currently shipping with cgroup v2 as
default (afaik.) and their kernel is compiled (5.3.7-301.fc31.x86_64)
with CONFIG_CGROUP_DEVICE=y and CONFIG_CGROUP_BPF=y, so this will not
affect them.

Odin Ugedal


fre. 3. apr. 2020 kl. 19:55 skrev Odin Ugedal <odin@ugedal.com>:
>
> Original cgroup v2 eBPF code for filtering device access made it
> possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
> filtering. Change
> commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
> reverted this, making it required to set it to y.
>
> Since the device filtering (and all the docs) for cgroup v2 is no longer
> a "device controller" like it was in v1, someone might compile their
> kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
> filter will not be invoked, and all processes will be allowed access
> to all devices, no matter what the eBPF filter says.
>
> Signed-off-by: Odin Ugedal <odin@ugedal.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
>  include/linux/device_cgroup.h         | 14 +++++---------
>  security/Makefile                     |  2 +-
>  security/device_cgroup.c              | 19 ++++++++++++++++---
>  4 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4a3049841086..c24cad3c64ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1050,7 +1050,7 @@ void kfd_dec_compute_active(struct kfd_dev *dev);
>  /* Check with device cgroup if @kfd device is accessible */
>  static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
>  {
> -#if defined(CONFIG_CGROUP_DEVICE)
> +#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
>         struct drm_device *ddev = kfd->ddev;
>
>         return devcgroup_check_permission(DEVCG_DEV_CHAR, ddev->driver->major,
> diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
> index fa35b52e0002..9a72214496e5 100644
> --- a/include/linux/device_cgroup.h
> +++ b/include/linux/device_cgroup.h
> @@ -1,6 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/fs.h>
> -#include <linux/bpf-cgroup.h>
>
>  #define DEVCG_ACC_MKNOD 1
>  #define DEVCG_ACC_READ  2
> @@ -11,16 +10,10 @@
>  #define DEVCG_DEV_CHAR  2
>  #define DEVCG_DEV_ALL   4  /* this represents all devices */
>
> -#ifdef CONFIG_CGROUP_DEVICE
> -int devcgroup_check_permission(short type, u32 major, u32 minor,
> -                              short access);
> -#else
> -static inline int devcgroup_check_permission(short type, u32 major, u32 minor,
> -                                            short access)
> -{ return 0; }
> -#endif
>
>  #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
> +int devcgroup_check_permission(short type, u32 major, u32 minor,
> +                              short access);
>  static inline int devcgroup_inode_permission(struct inode *inode, int mask)
>  {
>         short type, access = 0;
> @@ -61,6 +54,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t dev)
>  }
>
>  #else
> +static inline int devcgroup_check_permission(short type, u32 major, u32 minor,
> +                              short access)
> +{ return 0; }
>  static inline int devcgroup_inode_permission(struct inode *inode, int mask)
>  { return 0; }
>  static inline int devcgroup_inode_mknod(int mode, dev_t dev)
> diff --git a/security/Makefile b/security/Makefile
> index 22e73a3482bd..3baf435de541 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)           += yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)         += loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)    += lockdown/
> -obj-$(CONFIG_CGROUP_DEVICE)            += device_cgroup.o
> +obj-$(CONFIG_CGROUPS)                  += device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)                  += bpf/
>
>  # Object integrity file lists
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index 7d0f8f7431ff..43ab0ad45c1b 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -15,6 +15,8 @@
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
>
> +#ifdef CONFIG_CGROUP_DEVICE
> +
>  static DEFINE_MUTEX(devcgroup_mutex);
>
>  enum devcg_behavior {
> @@ -792,7 +794,7 @@ struct cgroup_subsys devices_cgrp_subsys = {
>  };
>
>  /**
> - * __devcgroup_check_permission - checks if an inode operation is permitted
> + * devcgroup_legacy_check_permission - checks if an inode operation is permitted
>   * @dev_cgroup: the dev cgroup to be tested against
>   * @type: device type
>   * @major: device major number
> @@ -801,7 +803,7 @@ struct cgroup_subsys devices_cgrp_subsys = {
>   *
>   * returns 0 on success, -EPERM case the operation is not permitted
>   */
> -static int __devcgroup_check_permission(short type, u32 major, u32 minor,
> +static int devcgroup_legacy_check_permission(short type, u32 major, u32 minor,
>                                         short access)
>  {
>         struct dev_cgroup *dev_cgroup;
> @@ -825,6 +827,10 @@ static int __devcgroup_check_permission(short type, u32 major, u32 minor,
>         return 0;
>  }
>
> +#endif /* CONFIG_CGROUP_DEVICE */
> +
> +#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
> +
>  int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
>  {
>         int rc = BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access);
> @@ -832,6 +838,13 @@ int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
>         if (rc)
>                 return -EPERM;
>
> -       return __devcgroup_check_permission(type, major, minor, access);
> +       #ifdef CONFIG_CGROUP_DEVICE
> +       return devcgroup_legacy_check_permission(type, major, minor, access);
> +
> +       #else /* CONFIG_CGROUP_DEVICE */
> +       return 0;
> +
> +       #endif /* CONFIG_CGROUP_DEVICE */
>  }
>  EXPORT_SYMBOL(devcgroup_check_permission);
> +#endif /* defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF) */
> --
> 2.26.0
>

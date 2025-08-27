Return-Path: <bpf+bounces-66655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7BB381A3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93D81BA67F9
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44535FC3D;
	Wed, 27 Aug 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzLbmb7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876935FC2E;
	Wed, 27 Aug 2025 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294835; cv=none; b=fK+CWRhEwbS0rTFI4ZD7E7XL7R8oQsglA0/wGAp4u2QvHrlfidj1u+063mj/5qkQPekTPjg5CD8nKiKqGzZXOfcWB1MGX70AnvyfTq0s9lUT9dHR3eaG1ss7ysNwSHtHR1GJdxk6ZXsM8DtTMxbx8coNlVMKUZ0dqP3D4ec7K0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294835; c=relaxed/simple;
	bh=Fk6GDvLmkCDGrIsjIvWcI3MTNYRmrykY6dKZ5Wy6aO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbTRdR3OOX2O3n8npT+RiDwayMhRe5ka4LpP7M/rZT5MDD6hJYDRmwXycVgHyCs6TdF8jeFEk3a8Qzwhke0grlgflM0CvT6ZeHJV+OQfAhw2W0tM+FYx81e0hyf7/eig0Ow3VhmhMkf+5G4XAoJ+9SEFn9q9s9stjoQWXiUXn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzLbmb7I; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a88de7d4fso57985896d6.0;
        Wed, 27 Aug 2025 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756294832; x=1756899632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeoM2pRAda8SuuPICRFUFFSQ54mI0ws6ytKPaFfrQVE=;
        b=OzLbmb7I2ZWHthlpMRX+ZJcEYakiSDApbeAbhpetM2xXjFcQawlfbCRXMlUR6AHUgD
         kxrhUUvU1rJdFQbV7WnYg/fs4JEnz57lYYpaOpsfhwr608N9Pl9SphsAUsVZCbEgj0FG
         qCJAuTRhs7K+R7QbkKjW8tJrs6Iyi5dG5n3gNeal/EUQSND6DhKRRygiUe7LnaYObcoW
         hY4eLBYhmWaf3CFmqImY99psAGjzT+YdhDYzcXh7Hk75R+DxkBRTh0b4HjDoOAd0XCo6
         qLb4A4BHZ7VR3eHntyQdPv6FgJs9q4Li7B0UhT6GSg1r8wqoYprYufwi7Op3i8MFWAos
         XjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294832; x=1756899632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeoM2pRAda8SuuPICRFUFFSQ54mI0ws6ytKPaFfrQVE=;
        b=wxwJrhTfnURpnn5PuMHXfDvHnL0uOjWeAfi/jSJtIzVUTqt1i4DwmjWgQbchwQt2qy
         JFLcXpyJqCa2YKGOfc0WtmTpd4xjSoTeM/cZXn9stpyEG3lliswQFTVfddVSpeBqYKwB
         zELOv42BIXEbsZO7pb3n9v5/tIC2akYISXglwLeIepaoMjDtWh0YsH+y3uPNaPSq9dFv
         b4b85YJ7gB8Mkgcc9Fv22+hNFPd1IwrDgW6MgZ1SIpeX9hLYfsodsAx5QvHrml8doAMA
         h9pX2W7ldgSpcgh/wXdAW7zt99w/au2emRrkqlFi7MLyYUxV8HmsbCb1dX/JQAO7csWf
         1YjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr7iA3WQMUDgI/spLLWI/fdvjQasR9hz+6UTOc5RAzhe5/dfJRf+j4H0O/+Z4jxvizdRA=@vger.kernel.org, AJvYcCWaGdtk8c2Xq75PjYmd/ja2wXMwiACq6HCsfswajclAjFDm43dtx8cN+DX6EkUcnSIiv89xHI/JeU6J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Jt1vfICW0mj7xWDdcfrlFmFcuq1NeLMg0MYhJZy/s8XDaNXG
	PCVb+VDTESYhL+CpAeNlDcBHkm50It+wXPOU0Y9RCz8erqbfy0oKnc9/vqVkrBCrtrBQ2Fr15Uj
	NPKG5shE/l2bXX4Lql1oeVpSOp51qwco=
X-Gm-Gg: ASbGncvBLvHyt72+l/OSbZbr5hN0i/omzhewTbhWhVMSzc07StV5sxuzcsVPHtM4tBE
	qjORn59dFOxI/7NggtWHs0OsCbq8dm14h8FgcArLEImHyVF3E7z+gJeNCFm2eY2NvgRwaAYfi6D
	uQogIiB/IKITvR2y3XyWCEYsHl6Mbu+dBG77ljTAf7cU+M3eZtAutNpiVmFR1EhJ1Dq69aogkFH
	u66qmtBObB9TKRxOWBEQystRT9EBpIvosC8QEGgcuY2XDSmgmc=
X-Google-Smtp-Source: AGHT+IELLrqV3R85XBc6agU/7DzAWxsj82fvVPd+3fVYozs8/RRKK8VEk3bA7WWCc4E5Pk4l/H0YX2Fkq99QBUTmqQk=
X-Received: by 2002:ad4:5cab:0:b0:708:1296:c5ab with SMTP id
 6a1803df08f44-70d971e4042mr226760146d6.34.1756294832315; Wed, 27 Aug 2025
 04:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-2-laoar.shao@gmail.com> <202508271009.5neOZ0OG-lkp@intel.com>
In-Reply-To: <202508271009.5neOZ0OG-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 27 Aug 2025 19:39:55 +0800
X-Gm-Features: Ac12FXwZr66D7NPE9H9ynH6vKXzl7w2VfiSW67LSXeqGM2TeN__rIRX4dJec3k8
Message-ID: <CALOAHbCtE-Sjeja3gzGwooWcikGWetPj8k6wqk52_c0hEo5ZKQ@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
To: kernel test robot <lkp@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, oe-kbuild-all@lists.linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:58=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Yafang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-thp=
-add-support-for-BPF-based-THP-order-selection/20250826-152415
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20250826071948.2618-2-laoar.shao=
%40gmail.com
> patch subject: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based=
 THP order selection
> config: loongarch-randconfig-r113-20250827 (https://download.01.org/0day-=
ci/archive/20250827/202508271009.5neOZ0OG-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b=
5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce: (https://download.01.org/0day-ci/archive/20250827/202508271009=
.5neOZ0OG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508271009.5neOZ0OG-lkp=
@intel.com/

Thanks for the report .
It seems this sparse warning can be fixed with the below additional
change, would you please test it again?

diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
index 46b3bc96359e..b2f97f9e930d 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -5,27 +5,32 @@
 #include <linux/huge_mm.h>
 #include <linux/khugepaged.h>

+/**
+ * @get_suggested_order: Get the suggested THP orders for allocation
+ * @mm: mm_struct associated with the THP allocation
+ * @vma__nullable: vm_area_struct associated with the THP allocation
(may be NULL)
+ *                 When NULL, the decision should be based on @mm (i.e., w=
hen
+ *                 triggered from an mm-scope hook rather than a VMA-speci=
fic
+ *                 context).
+ *                 Must belong to @mm (guaranteed by the caller).
+ * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is =
NULL)
+ * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
+ * @orders: Bitmask of requested THP orders for this allocation
+ *          - PMD-mapped allocation if PMD_ORDER is set
+ *          - mTHP allocation otherwise
+ *
+ * Rerurn: Bitmask of suggested THP orders for allocation. The highest
+ *         suggested order will not exceed the highest requested order
+ *         in @orders.
+ */
+typedef int suggested_order_fn_t(struct mm_struct *mm,
+                                struct vm_area_struct *vma__nullable,
+                                u64 vma_flags,
+                                enum tva_type tva_flags,
+                                int orders);
+
 struct bpf_thp_ops {
-       /**
-        * @get_suggested_order: Get the suggested THP orders for allocatio=
n
-        * @mm: mm_struct associated with the THP allocation
-        * @vma__nullable: vm_area_struct associated with the THP
allocation (may be NULL)
-        *                 When NULL, the decision should be based on
@mm (i.e., when
-        *                 triggered from an mm-scope hook rather than
a VMA-specific
-        *                 context).
-        *                 Must belong to @mm (guaranteed by the caller).
-        * @vma_flags: use these vm_flags instead of @vma->vm_flags (0
if @vma is NULL)
-        * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
-        * @orders: Bitmask of requested THP orders for this allocation
-        *          - PMD-mapped allocation if PMD_ORDER is set
-        *          - mTHP allocation otherwise
-        *
-        * Rerurn: Bitmask of suggested THP orders for allocation. The high=
est
-        *         suggested order will not exceed the highest requested or=
der
-        *         in @orders.
-        */
-       int (*get_suggested_order)(struct mm_struct *mm, struct
vm_area_struct *vma__nullable,
-                                  u64 vma_flags, enum tva_type
tva_flags, int orders) __rcu;
+       suggested_order_fn_t __rcu *get_suggested_order;
 };

 static struct bpf_thp_ops bpf_thp;
@@ -34,8 +39,7 @@ static DEFINE_SPINLOCK(thp_ops_lock);
 int get_suggested_order(struct mm_struct *mm, struct vm_area_struct
*vma__nullable,
                        u64 vma_flags, enum tva_type tva_flags, int orders)
 {
-       int (*bpf_suggested_order)(struct mm_struct *mm, struct
vm_area_struct *vma__nullable,
-                                  u64 vma_flags, enum tva_type
tva_flags, int orders);
+       suggested_order_fn_t *bpf_suggested_order;
        int suggested_orders =3D orders;

        /* No BPF program is attached */
@@ -106,10 +110,12 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *=
link)

 static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
 {
+       suggested_order_fn_t *old_fn;
+
        spin_lock(&thp_ops_lock);
        clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
&transparent_hugepage_flags);
-       WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
-       rcu_replace_pointer(bpf_thp.get_suggested_order, NULL,
lockdep_is_held(&thp_ops_lock));
+       old_fn =3D rcu_replace_pointer(bpf_thp.get_suggested_order,
NULL, lockdep_is_held(&thp_ops_lock));
+       WARN_ON_ONCE(!old_fn);
        spin_unlock(&thp_ops_lock);

        synchronize_rcu();
@@ -117,8 +123,9 @@ static void bpf_thp_unreg(void *kdata, struct
bpf_link *link)

 static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *l=
ink)
 {
-       struct bpf_thp_ops *ops =3D kdata;
+       suggested_order_fn_t *old_fn, *new_fn;
        struct bpf_thp_ops *old =3D old_kdata;
+       struct bpf_thp_ops *ops =3D kdata;
        int ret =3D 0;

        if (!ops || !old)
@@ -130,9 +137,10 @@ static int bpf_thp_update(void *kdata, void
*old_kdata, struct bpf_link *link)
                ret =3D -ENOENT;
                goto out;
        }
-       WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
-       rcu_replace_pointer(bpf_thp.get_suggested_order,
ops->get_suggested_order,
-                           lockdep_is_held(&thp_ops_lock));
+
+       new_fn =3D rcu_dereference(ops->get_suggested_order);
+       old_fn =3D rcu_replace_pointer(bpf_thp.get_suggested_order,
new_fn, lockdep_is_held(&thp_ops_lock));
+       WARN_ON_ONCE(!old_fn || !new_fn);

 out:
        spin_unlock(&thp_ops_lock);
@@ -159,7 +167,7 @@ static int suggested_order(struct mm_struct *mm,
struct vm_area_struct *vma__nul
 }

 static struct bpf_thp_ops __bpf_thp_ops =3D {
-       .get_suggested_order =3D suggested_order,
+       .get_suggested_order =3D (suggested_order_fn_t __rcu *)suggested_or=
der,
 };

 static struct bpf_struct_ops bpf_bpf_thp_ops =3D {


--
Regards

Yafang


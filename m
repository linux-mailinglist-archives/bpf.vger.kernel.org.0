Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4723F37B7E1
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhELI2G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 04:28:06 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:47856 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhELI2G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 04:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1622; q=dns/txt; s=iport;
  t=1620808018; x=1622017618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uYjvTuwDmwhkx2q4Y0If1qh3yeEnojSKi2padZH+nis=;
  b=NXjwBLP5mdn4xSdR1qRV807sgPl1YJvoeRElGAD0MaqCGWMv//wTcEux
   6vvwP5Y5dvkzp20+RSr03DZrdBphG7NhXf7ULg9pY722wdiBqptZbn9DW
   D60BhzBD/jeAGxiN9QQoMlondCWR8+K4I5kHyHXVgvvOqREH271xzMxeG
   0=;
X-IPAS-Result: =?us-ascii?q?A0BaAABDkJtg/4wNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UMHAQELAYFSUQeBUTYxC4Q8g0gDhFlgiQGZWIEugSUDVAsBAQENAQE6AgQBA?=
 =?us-ascii?q?YRPAheBXQIlNAkOAgQBAQEBAwIDAQEBAQUBAQUBAQECAQYEcROFUA2GRAEBA?=
 =?us-ascii?q?QMBIxEMAQE3AQQLAgEIGgImAgICMBUQAQEEDg2FPwMOIQEDnUgCih96gTKBA?=
 =?us-ascii?q?YIGAQEGBASFPBiCEwmBECoBgnqEDoZaJxyBSUSBWIJfPoRGFYMANoIrgnyBK?=
 =?us-ascii?q?UEwlg6mfQqDFJZ3CYZUEINXixIElkYtuHkCBAIEBQIOAQEGgVQ6gVlwFYMkU?=
 =?us-ascii?q?BcCDo4fCRmDTopdczgCBgEJAQEDCXyLAwGBEAEB?=
IronPort-PHdr: A9a23:TTR00RdaXvQksUcKbEaYXCvslGM/r4qcDmcuAtIPhLdHc6Dl9JPnb
 wTT5vRo2VnOW4iTq/dJkPHfvK2oX2scqY2Av3YPfN0pNVcFhMwakhZmDJuDDkv2f/HvZi0+W
 s9FUQwt83SyK0MAHsH4ahXbqWGz6jhHHBL5OEJ1K+35F5SUgd6w0rW5+obYZENDgz/uCY4=
IronPort-HdrOrdr: A9a23:yezm3a1cYgmMkC2PEklk0wqjBWdyeYIsimQD101hICG9Lfb4qy
 n+ppomPEHP5wr5AEtQ5uxpOMG7MBThHO1OkPcs1NCZLUjbUQqTXc9fBO7ZowEIdBeOjdK1uZ
 0QFpSWTeeAcWSS7vyKoDVQcexQuuVvmZrA7Yy1ohsdLnAJV0gj1XYFNu/xKDwReOAyP+tAKH
 Pq3Ls/m9PPQwVyUu2LQl0+G8TTrdzCk5zrJTQcAQQ81QWIhTS0rJbnDhmxxH4lInBy6IZn1V
 KAvx3y562lvf3+4ATbzXXv45Nfn8ak4sdfBfaLltMeJlzX+0SVjcVaKvi/VQIO0aaSAWUR4Z
 /xStAbTp1OAkbqDyWISN3WqlHdOXgVmiTfIBSj8AreSITCNUIH4ox69Nhkmt+z0Tt9gDm6u5
 g7gl5x/qAnfi/ojWDz4cPFWAptkVfxqX0+kfQLh3gaSocGbqRNxLZvsX+9Pa1wVx4S0rpXWt
 WGzfusksq+emnqI0wxflMfiOBEe05DUStubnJyzvB94gIm1UyRlXFosfD3tk1wg67VZaM0ld
 j5Dg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,293,1613433600"; 
   d="scan'208";a="698719816"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 May 2021 08:26:57 +0000
Received: from mail.cisco.com (xbe-rcd-004.cisco.com [173.37.102.19])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 14C8QvX5005466
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 12 May 2021 08:26:57 GMT
Received: from xfe-aln-001.cisco.com (173.37.135.121) by xbe-rcd-004.cisco.com
 (173.37.102.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Wed, 12 May 2021
 03:26:57 -0500
Received: from xfe-aln-004.cisco.com (173.37.135.124) by xfe-aln-001.cisco.com
 (173.37.135.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Wed, 12 May 2021
 03:26:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-004.cisco.com (173.37.135.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Wed, 12 May 2021 03:26:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1wXzH4DfrHOVXEzaQBXS9Nqa01Q/W2sJgd4Znv3AMfrye9vwYBvu9q+u159HXd0TX5ZPoPVYHdsehNjVvCMf0tTpTXoc2Q0NkG1F4uwXoLXoCugKcVSMDrtJdVzIQxcQrw07ATciDSkGSkiiaEFq/FaAFElsBJWy4Qb2nGn9NyiKDqqF30u1cUDuOE6Lb4RbsCGo4vsZYbVaAoqa1E4U/ZsYnzsNCe4Ypn/73P6UPAkobxG5zOJc35JlcO+l98dVlb4Sd7+IvyGDiyfsEHxvqdLJtYA0AYKb71PI3SecDaLGiTDjLGo8rM9UcVVBevN8VT6rB8l/G/aZFdqXARFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYjvTuwDmwhkx2q4Y0If1qh3yeEnojSKi2padZH+nis=;
 b=ZnuR3ZHHz0afJ0tzfkf7fmgYgy8gvOVaQO2yL3dC0EEJH8u34HttB0OeMDWrbXSFhu5N6JCQ51SN3ZNszvGI+FjNd9L9JeaBsW/IhcX8PHCiTvmfrCLDdlKZEI8rO4Pv+9WgqoeIHqVytFxK77KDNaHa0PMx0ob7/m1sSaltqPosLjUd94FbEMtlSbXj4X8WemypKdWYk6b8lmtWsuo0Jm0wqbxSQt6l0s66GZ3CYY3AHIEywDNFyFxyXCVLgNwWn+3/u2WDptXhURmufzVN/J0NG0YpPKlC3uJube938ta8RcjJ+Hmube4MB5OvD/9Nc/FZgrI4otFzAZaIMuMkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYjvTuwDmwhkx2q4Y0If1qh3yeEnojSKi2padZH+nis=;
 b=gGrtr1jPJ2ko2m66ly6Q6k9649jOLR1jVBSKl/JOKZf2aAW0wFLkGsP/xrloOn1b3+nDMmXYRx8uKdKlPaE8XpP+7WmkOJP3nRVktwwCtJwgnOJZW3WeuikqOBGytax/DAh3hOt/oRSgGzAgTZ/6JmtMMr6Kjk21ZvmylHHEMOo=
Received: from DM6PR11MB3660.namprd11.prod.outlook.com (2603:10b6:5:13c::17)
 by DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 08:26:55 +0000
Received: from DM6PR11MB3660.namprd11.prod.outlook.com
 ([fe80::d42:18c5:93bd:7127]) by DM6PR11MB3660.namprd11.prod.outlook.com
 ([fe80::d42:18c5:93bd:7127%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 08:26:55 +0000
From:   "Benoit Ganne (bganne)" <bganne@cisco.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: AF_XDP poll() / sendmsg() race + headroom changes
Thread-Topic: AF_XDP poll() / sendmsg() race + headroom changes
Thread-Index: AddFwES13atLgLM6TVaQYoFqwOtaTABMFB8AAAXHdRA=
Date:   Wed, 12 May 2021 08:26:55 +0000
Message-ID: <DM6PR11MB3660A5132EB554ED746C8C92C1529@DM6PR11MB3660.namprd11.prod.outlook.com>
References: <BYAPR11MB365382C5DB1E5FCC53242609C1549@BYAPR11MB3653.namprd11.prod.outlook.com>
 <CAJ8uoz16WLwqP+=dtphm7KWh=c9QYiU25k33hNrAg8ciaGe9vw@mail.gmail.com>
In-Reply-To: <CAJ8uoz16WLwqP+=dtphm7KWh=c9QYiU25k33hNrAg8ciaGe9vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [92.154.90.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1125fa82-7238-40bb-2119-08d9151fb3e3
x-ms-traffictypediagnostic: DM6PR11MB3082:
x-microsoft-antispam-prvs: <DM6PR11MB3082E7AE00369997841613DFC1529@DM6PR11MB3082.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7a6dtijH8ROj3sAgvCAZ7EdTKmRV3iZym8NCXK4rydx+U346di168DDTOypidxPXoAG8S0LTkxrTVtXUyAjE+8+fQHGN5f72pH/4VI6a29F/rp3RrGjteIkXVml+Nt2cDHxI7QO94/tNdoiRntCfdNhd/DCYFYONpYLGIPjo5rn7TdTIM+AQCiDnNP0p/V3bXXAjyqOYtzFJvR0BV423DYi3narHUkiF26fkxOWIrz9izzehB3XpGQBDn40IMHYL+QhF0A6CdY4OujxmBpcXDUiaYs0C9//3VtQsWElvAvHEhUb5/IaUtujkH6vg+ZMqi7r1QomgOP/MqKkGti0RZ0AVeohTXLoDBZHxxM9hgFzFcYJK3PEAhYdd9ZC9z4LynkN2yDfdK64AsaCGhCcvGRXhS7sGIUuLO0MStzIp1Hd9QeS/aNYDjTRunsB+i7YgU/YowfbTrC3Xb3PsurrA9PoThXaVA4/loerR1Mu7MwZNczrve2LqfC9uBUbDOwlpqC62QwNdTmJDPCfsvrAWT+26bfk9xHaOVbwJ6w4yDW86VD7l2lVZzixj/htf6oKaIboe41vOsrdvKdO/9vbmB6Rbmf+N57sVBrszMtDXog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(33656002)(6506007)(122000001)(478600001)(26005)(66476007)(9686003)(66556008)(66446008)(64756008)(4326008)(38100700002)(66574015)(6916009)(8936002)(52536014)(76116006)(2906002)(66946007)(83380400001)(316002)(7696005)(55016002)(8676002)(71200400001)(86362001)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tk8vSXBDenBoNXpYR2kvQTdnc0RVNUhPd1Q3ZFJZYVBxMWJWWUR3Nm9jdUFM?=
 =?utf-8?B?SldVenJ6YTVLSk9pNE9nWTF6S250QlRtWW1oZnF3KzUveEZqcUFhbDBhcWtN?=
 =?utf-8?B?SWFxdVIvdVd1RzNrT1g0Umhwa3dBKzB5RUJjZThzTFBwcTM1THNhMkxvMmJV?=
 =?utf-8?B?TkpLVldTOEdOVldSWkZQQndMcEVqK3ZDYlJpd1NpYllyQXZ0azZWamx1c1R4?=
 =?utf-8?B?QlZoSUFHYkhCd0RaeVdUSWdNdU1INnpNQm8vNEhQTnRJdUFSajNsTzdINjk0?=
 =?utf-8?B?MS8zdzBRL3JaQjlOZ2p6RGZEU3IwL2RuNm55N0NNeW1XREhCNGl0dWtEV3FW?=
 =?utf-8?B?VWMzYkhDdTNmdjdQeHR6c0hhakZ5Z2NrNlo4UlRjWm4rbk5rK2E0Ylc4N3M1?=
 =?utf-8?B?Z1ljTU5rN05mV252SEFINSs3WUFhMG9tWXlKTkZNNnMrVXBURy9rN01VaWl1?=
 =?utf-8?B?WExWZDN3bFZ1M0NaVll4SU13aWR1OVZiVTZKZ1hmMWRQanQ1VDUwTU1BSWIy?=
 =?utf-8?B?R2gxdlFObWdVKzhUWTZoNGZLMjE2NjBTakxrUHNUOGIwbEJwYTMrTEEvMlJu?=
 =?utf-8?B?d1dMcnAxU1lZTFNKM2RYbXE0MlMxNWExZ0Jnd3NLZDNoOE13ZjdmSXY5K0J3?=
 =?utf-8?B?R2txUk4rR0Q4MmtGQlpKS2YzVzFvSU05THBnTUYrdlZtMG9rdUVDSlZNcGt0?=
 =?utf-8?B?WDM2S3d2Rm93Z3UxMllPNXNDZHMwK1RBYzR0eEtsTWVvREJ5ZC95MUNCeHV5?=
 =?utf-8?B?cU9ReSs0M2grZ1NmMUx0MVkvdDBGN1Y0WDQ3aldmUEM1Y2hhRGJOKzdrb3hM?=
 =?utf-8?B?eW05dTVza1l6V0RwSi9VSi9hSFkxUTlmelQrMjk4MlIyR3hhLzdncnFzQ3Nx?=
 =?utf-8?B?WHFWYkw2LzZlZm1PcTNwY2d4MVJMSTVCdi9wdEN5MWRORGRoK0pVMzJ5S3oz?=
 =?utf-8?B?cUM3RktGRnZJSUJEU2tnWUNlUFNnT1ppN0twYVhHTU9YaVRpYjQxUEhHRnE2?=
 =?utf-8?B?dUNNOUhZZUlrS25pZVJOUE5wYUhGa0lJUCtKSHZaVERqVVFjQXZERUltQTAy?=
 =?utf-8?B?U29lR2l6QTJ0Kyt4Rm5WWWwzYWYyOEF4YkM5Yk54OEtpNnZYeU50NmsxVEJk?=
 =?utf-8?B?VUlrSVA5dUQwNkhxNk51d2dic29Fcll0c0plaTNuWUF2RkVlSXRkRzczbnQr?=
 =?utf-8?B?SHgzUkJpSmRzb2Q0M0RySTNnOVdvbXhiVmRvVXRvZDRTNkJxaXFFTTNxSEc5?=
 =?utf-8?B?RW9keWtMbUptMW5JeCs2aFlvKzNkQUdWVTZZek8wRVJ3Z08vQUNySVBoQ01R?=
 =?utf-8?B?R25tTUJlYWl5b0hmMTJyYmd5TlVjRXJCdWl4Q2Z5S3FVREFWaVBlNnpvRGRM?=
 =?utf-8?B?TWRDZmU1dTEzVnROcW5EbEU0RlllQUYrOGNuc2NseW8wTDJUVU1QdWtGRTd0?=
 =?utf-8?B?dUZTN21RYTN2cmp0MXVzbjBNc0F5UlNDU3ZNRlI2SlB6UTMvNU9NYkNJZ1ha?=
 =?utf-8?B?U2RUM2VXbTg1MGlrQVBYNVdYeURYL1owdm9kYnhyaTVnMVNXYnFHZGIzejVP?=
 =?utf-8?B?L1IzZEQ2UGZBU0dmNUNtTTY0RFdYUWdxeXNpdzRjcVFzbkVxdStsVDNsaENx?=
 =?utf-8?B?MXo5YXdLbWt0b2RnSk5aUXhQSXhxQkR4YllXVUsrclZuVXg1MzdJWUtwQUJZ?=
 =?utf-8?B?ckhaUG5UYlJOS016S3dMSkVHdXU2aG5ZYjdWdmVjaVJ3WklRblpIdHZWNmpN?=
 =?utf-8?Q?aktYBSLsOJLAsw4JdIPDC1/H8Epib0KQc/sgx1T?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1125fa82-7238-40bb-2119-08d9151fb3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 08:26:55.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NgbM2OzzYaxkKH8kCC5kt+S3htXj7MFRf7y5wOwJk0o4NybbcFvvHSUeJMQDOqiL2sKkFW6OV+DG4JNFKOo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3082
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.19, xbe-rcd-004.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgTWFnbnVzLA0KDQo+PiBJIGFtIHRoZSBtYWludGFpbmVyIG9mIHRoZSBBRl9YRFAgZHJpdmVy
IGZvciBWUFAsIGFuIG9wZW4tc291cmNlDQo+PiB1c2Vyc3BhY2UgbmV0d29ya2luZyBzdGFjaywg
YW5kIEkgcmFuIGludG8gYW4gaXNzdWUgcmVjZW50bHkgd2l0aCBrZXJuZWxzDQo+PiA8IDUuNiAo
aW5jbHVkaW5nIExUUyBrZXJuZWwgNS40IHdoaWNoIGlzIHNoaXBwZWQgaW4gZWcuIFVidW50dSAy
MC4wNCBMVFMpOg0KPj4gaXQgc2VlbXMgbGlrZSBvbmUgY2Fubm90IGNhbGwgcG9sbCgpIGFuZCBz
ZW5kbXNnKCkgY29uY3VycmVudGx5IG9uIHRoZQ0KPj4gc2FtZSBBRl9YRFAgc29ja2V0LiBJcyB0
aGlzIGEgc3VwcG9ydGVkIHVzZWNhc2U/DQpbLi4uXQ0KPj4gSSBoaXQgYSAybmQgaXNzdWUgd2l0
aCBrZXJuZWwgPj0gNS45LCB3aGVyZSB0aGUgaGVhZHJvb20gb24gcnggZm9yIGNvcHkNCj4+IG1v
ZGUgaGFzIGdyb3duIGZyb20gMCB0byBYRFBfUEFDS0VUX0hFQURST09NICgyNTYtYnl0ZXMpLg0K
Wy4uLl0NCg0KPiBIaSBCZW5vaXQuIFRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nLCBJIHdpbGwgdGFr
ZSBhIGxvb2sgYXQgdGhpcyBhbmQgZ2V0DQo+IGJhY2sgdG8geW91LiBOZXh0IHRpbWUsIHBsZWFz
ZSBhZGQgbWUgYW5kIEJqw7ZybiBvbiB0aGUgdG8gbGluZSBzbyB0aGF0DQo+IHlvdSBnZXQgYSBx
dWlja2VyIHJlc3BvbnNlLg0KDQpUaGFua3MhIFN1cmUgSSB3aWxsIGluIHRoZSBmdXR1cmUuDQpJ
ZiBJIG1heSwgYW4gaWRlYWwgc2NlbmFyaW8gd291bGQgYmU6DQogMSkgdGhlIGNvbmN1cnJlbnQg
cngvdHggdXNlY2FzZSBpcyBvZmZpY2lhbGx5IHN1cHBvcnRlZCwgYW5kIDExY2MyZDIxNDk5Y2Fi
ZTdlNzk2NDM4OTYzNGVkMWRlM2VlOTFkMzMgc2hvdWxkIGJlIGJhY2twb3J0ZWQgdG8gTFRTDQog
MikgaGFkIGEgd2F5IHRvIGRldGVjdCBkaWZmZXJlbnQgdmVyc2lvbiBvZiBBRl9YRFAgKHRocm91
Z2ggYW4gaW9jdGwoKSBvciBnZXRzb2Nrb3B0KCkgb3IuLi4pIHNvIHRoYXQgSSBjYW4gZGV0ZWN0
IG1vcmUgZWFzaWx5IHdoYXQgSSBzaG91bGQgZG8gYXQgaW5pdCB0aW1lLiBFZy4gbWFuYWdpbmcg
Ym90aCBoZWFkcm9vbSAoMCBhbmQgMjU2KSBmb3IgY29weSBtb2RlIGlzIG5vdCB2ZXJ5IGRpZmZp
Y3VsdCBpZiBJIGNhbiBkZXRlY3QgaXQgZWFzaWx5DQoNCkJlc3QNCmJlbg0K

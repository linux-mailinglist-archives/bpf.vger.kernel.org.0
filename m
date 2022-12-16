Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D564EDA3
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiLPPMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 10:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiLPPML (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 10:12:11 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11021019.outbound.protection.outlook.com [40.93.199.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94650D48;
        Fri, 16 Dec 2022 07:12:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA5JZjbGeH5NV+oFQayp8CkgqP/5GC/qu6UuLaPESHPI7Tm5ZD97L82wfbKdhf7rtt07EPgNlar05oYoN2TfCPwSNkbP3+K19iFOqwkaLw0Sv5Z5zlzRF4mUFDaF5LPHdk08QW3Xs9ocfPkoQZ3fG0I8yQlX/RSAsQQG/Dnl/DkLUzUay2BwXjaiirasV6x/VH3DJ0UZkWl17VsKtUDHrjyelRDMjxXgFfD/wTtMs3Sh+q+/wi7gd+DW833pEgxau/kPYfgTXTzycRCmtedGP/69riS87unYd33ii73YLm6E+zn2IiqhGT9l8ToCfdK56V2P9v/dgfVh6an46KWY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNcIOK39ZQX8ctpMrqSqzMJsDywaM66Ha0hwWrkC+fE=;
 b=ieYDK+n9XJDvOo33v0z2MDJG+kpPAOrofd2u37s2byXQ7nHsY8txorfq0VV/EKh1rmzhhHLguQ/YFMHS5Rc9e18VLWwkSaO6TE6E0hGgV2vf40PapaHzXtzp1Vm+UVX4a+F1PJDGSYWs2q+Nz1xt1TFpcRfb1f9JPO2Mctccosqt/69HCEIq9SZUOXFb6DR7oC7ls9g7jY5V0EAUxGGv3+0+zjQA8g9tO9FyJK90zGYxHy4tl5fBQb/BpIp6zZTCrw3YUjh0qmhf+HlH9WrlybCv7rSZpEDbvcuIvl92uS1eCZdtLqTQ4Lr/+JW1VZmEILKwXkJfcQvRwBzqYFN2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNcIOK39ZQX8ctpMrqSqzMJsDywaM66Ha0hwWrkC+fE=;
 b=jRkAqIu4b6hND+5biTLLLaJMrAgUkihjyw6Xy0F/ujqf5Vb1llQcBkQkooZI1SX9B/nbDvC/kTOp4E9nw0WQscbRp+QvEl9F7zImNnMN9xAp+YIOh62Rq9oVC+MY7yeIgpf+qfmDZWqeh1nzThSy0D2ItkqbQkt4zhDTqO7dJLk=
Received: from BN6PR21MB0788.namprd21.prod.outlook.com (2603:10b6:404:11c::17)
 by CO1PR21MB1282.namprd21.prod.outlook.com (2603:10b6:303:161::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.3; Fri, 16 Dec
 2022 15:12:08 +0000
Received: from BN6PR21MB0788.namprd21.prod.outlook.com
 ([fe80::82e8:8caf:81d7:5d46]) by BN6PR21MB0788.namprd21.prod.outlook.com
 ([fe80::82e8:8caf:81d7:5d46%8]) with mapi id 15.20.5944.006; Fri, 16 Dec 2022
 15:12:08 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "mtahhan@redhat.com" <mtahhan@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "jbrouer@redhat.com" <jbrouer@redhat.com>,
        "thoiland@redhat.com" <thoiland@redhat.com>,
        "donhunte@redhat.com" <donhunte@redhat.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "void@manifault.com" <void@manifault.com>
Subject: RE: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Thread-Topic: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Thread-Index: AQHZETWa7pxi9i9VV0SS3Z6YJXXor65wmwBQ
Date:   Fri, 16 Dec 2022 15:12:07 +0000
Message-ID: <BN6PR21MB0788FD10541056AF887B2B80A3E69@BN6PR21MB0788.namprd21.prod.outlook.com>
References: <20221216100135.13125-1-mtahhan@redhat.com>
In-Reply-To: <20221216100135.13125-1-mtahhan@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=728725cc-a53f-4e95-883f-ff31ad574807;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-16T14:57:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR21MB0788:EE_|CO1PR21MB1282:EE_
x-ms-office365-filtering-correlation-id: 68b0fd53-37ef-4d94-d79b-08dadf77e5a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UwnW8U8kEAL0yc9cSkSpPfO9M1bFjFoOnJW1s6AAkDz/T8fNTSzNpDLRnjePDIjRMTivvMjkQl0Wb0mEsk1Kso1fiEoGRL0GcjZ1yWya8E+C2gHbck+XOklQvGBJUvDdhhuJGyNqzh/7QLxI67iMlCKOo9n0rWMaFyGstG1h4AiZ+kYXZO6Zrv1AJs3t1/3nQmucl1TtswfRMMTHaEFqY//K7e878YXRydxUuoFLXr8LRJgAjjPWfzA5He2uz54qS7hPjDgVXgxy7e5gbZlS8U15d6+6tqG4hTFp8+nVTaHiL3coyZzaTMOK9cMW0Ht9lHzw4h8wz0MqOiZFN36nDbN/fcBysycIgqeQn0yphJ0E8K3nroqewBpRigIIGuBRpyHVkTeGILXmoJB66Mzq3V+28vg04F7tQ28ENuYO7PEKyD/Qpzpsfrhy55r71gDYMrF/DuH6sGjA5lJfoBL+rc3nIvMQPPqvzzK+AdOnyo9Dtz5VlE8Zz5SSzYyMBgonwr0cP86p5AnHfW6InMT5DIZY5EOeFYAuiVN25NzChszFc2lVhG+KvPri/QZVoqdshYIKO4ku0mimDkcfhwvtlUhn3DkMxb31/LkAejbiwocneVan5vh8K8C3hZnSUHGgirgzg2p0RNkoTea+OXDQfqLeZJbCTA0eWtMN1qv3Ht6+Dw8oKhH7eqRslvVt59hzQIWXrf1AQrNir0MTAqfDW422+vIgoCcgJx1oT28yNQDIpw8rx/lWbgPKIYrZPhk4kjm1oY4dDJtK2WLTTYPXGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0788.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199015)(8990500004)(64756008)(2906002)(66476007)(33656002)(66556008)(66446008)(8676002)(76116006)(52536014)(66946007)(8936002)(86362001)(4326008)(5660300002)(110136005)(54906003)(316002)(38070700005)(55016003)(38100700002)(41300700001)(122000001)(478600001)(71200400001)(26005)(6506007)(9686003)(7696005)(82950400001)(186003)(83380400001)(82960400001)(10290500003)(83133001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G/8p+nlTWVgn+LAwl/DzHTsI3XMvvZ7oPER1O+HEFultL5JNp7C64EsaDcuh?=
 =?us-ascii?Q?xP0MSIsMyvWlgFdvedaWeE7pU6iuQh35aAmmMg0fiaMSZ8B9Od2iTFpY4lQK?=
 =?us-ascii?Q?f7RdxR0g2bCP24lF+hxLJUPnLr83/j+Vfn9t6EEed5r449PNmE9TztIvJXg1?=
 =?us-ascii?Q?Qw2Lzj4s1TgwHZWKwwQm1dI3sj21Lqv8ZCoGoEiLLdtRlM/asSp7/7BDaB1B?=
 =?us-ascii?Q?AuPuKMrlwA3ptojLDHHaq6IAevBp75HBogmK128tiGpvB09ds2DmSGDlZXcn?=
 =?us-ascii?Q?9hUIUxHh9avgiNO/hkf5CCwodFauHVMTWb/taVwi2iZZrAnkuvCiXBDZgvW3?=
 =?us-ascii?Q?x87OcyAeNBglRrmlmAqzciHrzUK4aRSvVJXlqe4Lvcp+FIzDPVO9z+Ov+QLn?=
 =?us-ascii?Q?+o1e6qHqYHpx30XmdH3dbF5p1F6v6qWs95VazOYzty/2Qt5c1JurbaNhvRlt?=
 =?us-ascii?Q?xIb86Vydr6jfMm6zILJ74ts6dvEvg+uErK5LrnzcEFW6XJ3qEiFsyGMnNDOU?=
 =?us-ascii?Q?7HCqs6BeCv7mZvDD+T5t5qVqtOAxK1Upy/BvkY9LBcljy15u+7g8uzlqHaS+?=
 =?us-ascii?Q?HrUX6pEKZTHLZmPSbsDbOnHjZ0fH+crqrl1ZXUfLef6BYIuZwoeP4bad9qfd?=
 =?us-ascii?Q?/0YDl0imTgczrMNff1ERroS4jDEo6YHRkT1CRHx+5cYP1p0Ta7txsn8fj5Dr?=
 =?us-ascii?Q?WRtCWt5d2Fx8DQyukom/cx4x5rmrEttOwMw2UHAWl6uA4ZqC0ynHxA0wc/gS?=
 =?us-ascii?Q?3sOLVImeM0HeAoKfeng0eD3dKG9kvevY6Tq0H2N7Vca1KiQ/ujFZeyNxoWDD?=
 =?us-ascii?Q?KCgdhkzVUy8EAdtgoDkK00lzQRbYwnNL04nXfZnmDdxiABVWRQh7RMHrlPJg?=
 =?us-ascii?Q?yavLeeEWoPO77I47LDhrdzo+TTb0Lw5QYZelTsRvF0L+0yeiSgq45AflCbDp?=
 =?us-ascii?Q?QVngly2LaxMVlrKOB3RcPcqmirJYNllJtVhjr0XRUOlU0ccaizEtQAvWktVg?=
 =?us-ascii?Q?XoK9vuOoOW5KD13O6YdeohZlFbT8ucFZIrRyxP5h1TkAQCEDqcApC2+IZt7M?=
 =?us-ascii?Q?G38qgq5PqztKprF02M7i1pZqNXYC9T37Wq2f/Z5LWKJzkGf/rcbGYyg+KlHG?=
 =?us-ascii?Q?vgJc0GJJDHTGhJ1/XjzRwV41u6CJSkybMh/EJBOLItP1DU/ilkyMBah3dFpn?=
 =?us-ascii?Q?bvzV//3/EDBLEuCtKRwOsAEyj6iEG4mIimOwLgA9P38yf29mL/FaYAovZa5u?=
 =?us-ascii?Q?RQI65KP6XJPfnFr8QmRXfV/XcyyFHIuH6vozcyFc/2MaLDnoNjqB4LhS2dYK?=
 =?us-ascii?Q?04JpeX2CCYeVgk0vMwn3u2xqx2BXLIJ6JHbaBLnrjKyk9cAC/nnaj3uIieYH?=
 =?us-ascii?Q?olrfeFk4qp40vGvebeLU8HhuayoAh/XgmPGYXBX4bSBBW1A2K9hf9ixG7WAg?=
 =?us-ascii?Q?ZuBnh0kfBK2OgBsrgnMfiQ0+Kzr1wwewy9QnUesYFr/wqBLyNYaGwb5i/HLm?=
 =?us-ascii?Q?a0LsP8P9SZe3MfIHD/K6JjLC2obpp7Mk4H+AQ/S1t5pnWUZ8MmnzVEzlW5et?=
 =?us-ascii?Q?UegzViyEJESm2PNTnBMYT3eTVYEhtX021Lo7CXxlZblzHKhYf2k7Z2pSMF9j?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0788.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b0fd53-37ef-4d94-d79b-08dadf77e5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 15:12:07.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X46VNYnKgD8VPeSquGBDjgj99ZUwACRg2nn6AIAhGTE9q349HxqOwOIIAUPWDrfF/09X2e9iuk48LbnomlY1UW8ZlNmT8T2wYx7K5BN0E+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com wrote:
[...]
> +A sock object may be in multiple maps, but can only inherit a single=20
> +parse or verdict program. If adding a sock object to a map would result=
=20
> +in having multiple parsing programs the update will return an EBUSY erro=
r.

s/parsing programs/parser programs/
for consistency with rest of the patch.

> +.. note::
> +    For more details of the socket callbacks that get replaced please se=
e
> +    ``net/ipv4/tcp_bpf.c`` and ``net/ipv4/udp_bpf.c`` for TCP and UDP
> +    functions, respectively.

Why this note?  The rest of the text looks to be usable cross-platform
but the note above implies that this documentation is lacking and the reade=
r
has to consult the Linux source code.  Can more be documented
in the doc instead of just in the code?

> +Finally, the helpers ``bpf_msg_pull_data()`` and=20
> +``bpf_msg_push_data()`` are available to ``BPF_PROG_TYPE_SK_MSG`` BPF=20
> +programs to pull in data and set the start and end pointer to given=20
> +values or to add metadata to the ``struct sk_msg_buff *msg``.

s/start and end pointer/start and end pointers/
(grammar)

> +copied if necessary (i.e. if data was not linear and if start and end=20

Nit: style manuals such as Chicago Manual of Style say to always put a comm=
a
after "i.e." (and "e.g.").

> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +.. code-block:: c
> +
> +	void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Lookup a socket entry in the sockmap or sockhash map.

Grammar nit:
s/Lookup/Look up/
("look up" is a verb, whereas "lookup" is a noun)

-Dave

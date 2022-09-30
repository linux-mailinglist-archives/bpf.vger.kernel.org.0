Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0BF5F166A
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiI3XBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiI3XBQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 19:01:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2122.outbound.protection.outlook.com [40.107.95.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EAF10C79F
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw/+42NYmnDrleHFyX3Jbo4he0kz9LbsI8odOAEdCh/p6MJj6gYmjNwEl3Iq30p7OLJKGC82I9MuevHbBtO+8EUFSgQId/Bgu4LtGy9qIJOe10EfSrlUf3lW7qWCJLaXjXw2aY5LXex5ZCg4UxkcXd5vegiwkMGRnNI5/G+tSIgMRmPl0thLjQo1cRx7nwFCWaKZDLAaSuTMywJ3TRR4bzkfAQ+UtXQ7vClL5cH5R8/qvY2g87v6qli0RIn3mmtblKttCSJp7WRJaySu6VgvCOFDjNOSjeEV4ZT3SE/tW4BpoCqCKqCKOBpsqZlIxxffYH23cybW77SXRxpgH1oQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOBuh00vJ5mLb37ldJk4Qwy6YAbw6o1ljPs2gnfK91A=;
 b=GunEXZ1eHkyLx/r8O2DmBhOoshCaiQLaGeVahgnbysdR3JoIA2cNYwS6Q8NBfFWcLluOkndKsCgazMPbtJjSlSibexr/VpgnF6NXI9mFMTXvekZYA2i8BPzU+ull1SgGmGQd/swDmHiyDsJoJeeDRcZUT2zOtkBUaLCuPpkShXrGujQvEtE3Pc3Ch7uVp85/yD+9hzOoWfOOHRtGZ6xfwuBYKO6l10mHNr3FSnk7HC/aVT3zjVwK/geU20g+5yWhiSOT22Qp6Ud0WjOcfK9AmwTuqEoafJhB063AOTumRTcEDCcIJH3tYHs5O7v158XMZtlOWKm2NqlC0uIkaM41bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOBuh00vJ5mLb37ldJk4Qwy6YAbw6o1ljPs2gnfK91A=;
 b=EbdwKCRBnP/gRDay6GzhIbqdZyi5jUhsiIr4Eof+OBBD9s9cga6gH6gvHwX+zZvHUyFo11UKy/IeNsp9hbur0U897cvO5a6KlWQHHTrcJaBllnX5O067JoC0To4Yjd1ccMl3v3B352MnLf/aQpjepkOtnWft/QEnQs0L/4KGPKc=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SA1PR21MB1287.namprd21.prod.outlook.com (2603:10b6:806:1e6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.3; Fri, 30 Sep 2022 23:01:12 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5709.001; Fri, 30 Sep 2022
 23:01:12 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 09/15] ebpf-docs: Explain helper functions
Thread-Topic: [PATCH 09/15] ebpf-docs: Explain helper functions
Thread-Index: AQHY0qNneiBmPYJmkEmvS44NC5eHM634iw+AgAAP9bA=
Date:   Fri, 30 Sep 2022 23:01:12 +0000
Message-ID: <DM4PR21MB3440749D5448493AA53469FAA3569@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-9-dthaler1968@googlemail.com>
 <20220930220119.wicafybgabixr2b3@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220930220119.wicafybgabixr2b3@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6b6b277d-4e93-4746-a6a7-35d725f4215c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-30T22:58:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SA1PR21MB1287:EE_
x-ms-office365-filtering-correlation-id: 777f8541-66a8-4b40-9d04-08daa337ab8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wq60VXmo1N9K3vuBLPh6OneQXCop9QcU3GofVpeOWB2kLS0pOODSNLUR7//gx2YfLaqqKuUsFmE77HS+LG24Lg8lmh7gkKsXcHlJWHdvFOd/qhEI+Maj+AaSLvB5B6vsHpMAkc/XDzEfDF10dXP43cW8neGnb/vkwe64OoGTLVXvy+F/z/DsPD1TVmG0kcUt04fLiOzfdCigEWPIrEsF4uyY9gIF24V5OTq+i6wdaCV0bI681eHRJPh3OMDs0+qzeearcTxJxi9osjBw6Qpwv07r0EevnBnK+KswW+Ao8P3JHts/Rtqnk+KFOcbE2YARGaOx0zfyGaGLlVjUxcsN09rzzytZm9/FZn/jH1/PPXc3aQVOOaIH7K6eJYucaXw/gyquIXhMR7zsJrLEhsLxTagwHs2zutk23caMxYLCM3oHWcaSorQmKZbE1+ENkZWHGltM7u5XxTFlCqAfUaa5i5yG+ZHXTm5X4kij2ibHjAUzQ9GKNtJWF/+j6Qc/d7EgtU8/M53Ms5kQ1EdVrT4NKLdeS0BwQ7o8iJscaeGOrjevifiUuBPwlZBT66xFe2IAK5VY0lVDswWVnYhaAHnOuxyYjQDV9xZwWKy9sRXnKalOKc+AKf0AsUtanruwlF7ce7hrEor7J+EmJQEa9IcJgHvBZibewlznJedaZYPARB/gOynhbliGaSaSaealHQDQTqB1PV9iqyOfyKmd3f7UrpC3R2FOsyToZKajUHCfa4GmkvybLbHz/AcUGzLzWTFbhZ90YH9mcoLQTV9wavrkJRISQHBbEmff9SsZZHfnV+X45DfK8cHMC4sPVf55EG1H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(2906002)(8990500004)(316002)(66446008)(66556008)(4326008)(66946007)(64756008)(8676002)(66476007)(8936002)(33656002)(76116006)(478600001)(10290500003)(71200400001)(110136005)(41300700001)(52536014)(5660300002)(9686003)(6506007)(26005)(86362001)(7696005)(55016003)(82950400001)(82960400001)(38070700005)(186003)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pebsIo5nl295nO94LZdsetW76iPhhuU2EDmC4s7JbFCAwSxRkKtbNAP42cbf?=
 =?us-ascii?Q?VmaPCGmDmFKQVrNAaJ+mX4TWkwDIrrgeIQ771j9A0yDmNMsjqgP82Mkysmti?=
 =?us-ascii?Q?ZwgJPqNIHoUuyHNxkodY7m8+HcW2BduXUjmAGyyssI1VuvhlDpq3KMuU/Uz1?=
 =?us-ascii?Q?MIkTqkNT7kuXsbHug+OZOfUl1zziR8V1xS1ziqnoXFs2cEYrvVAjnX/bWnxp?=
 =?us-ascii?Q?/OvF6rGUmeLgBsb5/rE/DpiFjxZf9aRoSzmejyoHgB5D/q8rQIPKYTdJD0cl?=
 =?us-ascii?Q?Ir0Z0s7uaKTquhNkAQvff5QxITe0X9UPWNHmQXkmkhs1WbAGPKEF89P7o9Bp?=
 =?us-ascii?Q?8cV87Pk+6pJ26IdQ4Tk3PNUfyMzdhaxRaNjBHrSEAxYU+7WgF+2Yf+oVXp6C?=
 =?us-ascii?Q?tLXHq4h4NCmxETpZKqQcp/Zs5AwYYQCA/voy0DSmAvz0OH/4URlKuA31RXb1?=
 =?us-ascii?Q?eeGZnYQsCu/VxClfEv0bKaMIGQCLMSulvKKq8I2iIBTtdWdscW/nz8FR1/F4?=
 =?us-ascii?Q?3NM2ue4NxIhBXmj6NkKzPPctSYpUrJuO+BgDbgyB1GN+v29GIxO0+J1leguD?=
 =?us-ascii?Q?w85cF37gAw5g+fGD3usmwCSGbKZM1nmZx+g4o4VZufPaShqPK/x2dlmrtoSD?=
 =?us-ascii?Q?9suHWlCuUCF0G5R8VQ0BEq/ww4I1hy8OrHtMLs9MckOM80h8bbAdvQzs3W+R?=
 =?us-ascii?Q?J17nQtjbJeSboIXArwA7HoQXxHGe0kGZdonvHqfjGcGYSZ7XI+KyYEQIS9Ih?=
 =?us-ascii?Q?WoDFDWrKffDBl+B1qGFR1CDoYe3+JpuRbarV+cfVKktZNcHUxddP3QJ8E1j2?=
 =?us-ascii?Q?I4SEUutQ1SGb7MLS0qoZ4rL30Ud5NolN4gRkQ/4fiy/9fx47fTKSkEBevNdI?=
 =?us-ascii?Q?n6WaKX6i+v2BMem0nENTfxV6MVrgLrShTXNzrpxl7bLBUm2aUcZZuxfhmzbY?=
 =?us-ascii?Q?sp1HZTlPVgCWBrzYGi0Z/VzJQRJQ1u7veJVIMoqkpquN8kE+1sx5MW8N5Unj?=
 =?us-ascii?Q?iqyI1/RbJDxdE0HsSswjt+d8kG+OKyO8iUK7BGJ3Xfy8ZKXQ+XwIN/7OagrY?=
 =?us-ascii?Q?fejDE5pXZtCGkKkbOXQ4/oyeDzCa2BLABm06yFLCAZrU7LisRw1zQpBxCbh6?=
 =?us-ascii?Q?daqEXWZttfQRhqdPzJCctqNoFUKZ4oteMOnff5dje26KFzIbDh8YC6CxXdb+?=
 =?us-ascii?Q?Q5Jm5bvIy2vN1AMo+CHRUDz/tugndTza876TbkPdlLGW+k+N5sZyWRxXRQLs?=
 =?us-ascii?Q?FWAXn+xFDofurLHl6q9cS8T8TvkvbuF0Ax9qr2LYlWdgkS+AIWaeGZK5v/FN?=
 =?us-ascii?Q?5kzATRgs5rY422aWJI/3E2L0ZyfS/bNu4P8LoKAcXhYpuokKrExIb3ifB5sc?=
 =?us-ascii?Q?uJZtSyG4NPuOBmlOqCGCj15OIByNSJzmjAB/BZbtGJppmbicGzg7i8qrkcj0?=
 =?us-ascii?Q?WIpGgW2hEyxIRd0t98+Lyx72/x3ulo/hXmtQj6dAaP2sjRZAQLZDT2Qdlu5V?=
 =?us-ascii?Q?FxXuPvYILiN63qCmGkgBJjy3S4JC77J9gunfFE+YGCe9cXVpHOm6nPzhU6ta?=
 =?us-ascii?Q?CujT2flQ9oFn4dU9Kn6rQgvH0ZxUDA7nyGQmjn2n52dT2VahLp1f+eNoxpxT?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777f8541-66a8-4b40-9d04-08daa337ab8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 23:01:12.2656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2umuJ8vqY53S6lIfS0shSby+j+wVExG3nsAiQEOfeHqa/224ZGYKDziwZ+GuppRIz4wVqUi++mL4iYAr8pua7Lzmpx5lTdPyTMbHz+1DMco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1287
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
[...]
> > +Helper functions
> > +~~~~~~~~~~~~~~~~
> > +Helper functions are a concept whereby BPF programs can call into a
> > +set of function calls exposed by the eBPF runtime.  Each helper
> > +function is identified by an integer used in a ``BPF_CALL`` instructio=
n.
> > +The available helper functions may differ for each eBPF program type.
> > +
> > +Conceptually, each helper function is implemented with a commonly
> > +shared function signature defined as:
> > +
> > +  uint64_t function(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t
> > + r4, uint64_t r5)
> > +
> > +In actuality, each helper function is defined as taking between 0 and
> > +5 arguments, with the remaining registers being ignored.  The
> > +definition of a helper function is responsible for specifying the
> > +type (e.g., integer, pointer, etc.) of the value returned, the number =
of
> arguments, and the type of each argument.
>=20
> If we explain helpers in the doc then we should explain kfuncs and bpf-to=
-bpf
> calls as well.
> Otherwise it looks incomplete and eventually will suffer the same issue a=
s '64-
> bit instructionS'.

Agree, and blurbs were indeed added in=20
[PATCH 14/15] ebpf-docs: Add extended call instructions

Dave
